defmodule Cockpit.Agent.EncryptedSocket do
  require Logger
  alias Cockpit.Servers

  defmacro __using__(_opts) do
    quote do
      import Cockpit.Agent.EncryptedSocket
      
      def handle_info({:tcp, _client, _data} = msg, state), do: Cockpit.Agent.EncryptedSocket.handle_info(msg, state)
      def handle_info({:tcp_closed, _client} = msg, state), do: Cockpit.Agent.EncryptedSocket.handle_info(msg, state)
      def handle_info({:tcp_error, _client} = msg, state), do: Cockpit.Agent.EncryptedSocket.handle_info(msg, state)
    end
  end

  def send_encrypted(data, %{socket: socket, server_id: server_id, session_key: session_key}) do
    iv = :crypto.strong_rand_bytes(12)
    {ciphertext, tag} = :crypto.crypto_one_time_aead(:chacha20_poly1305, session_key, iv, data, <<server_id::big-unsigned-32>>, 16, true)
    :gen_tcp.send(socket, iv <> tag <> ciphertext)
  end

  def handle_info({:tcp, client, data}, %{server_id: nil}) do
    :inet.setopts(client, [active: :once])
    Logger.debug("Received join message from new socket")

    <<id::big-unsigned-32, iv::binary-size(12), tag::binary-size(16), body::binary>> = data
    server = Servers.get_server!(id)

    <<public_key::binary-size(65)>> = :crypto.crypto_one_time_aead(:chacha20_poly1305, server.api_key, iv, body, <<id::big-unsigned-32>>, tag, false)
    {my_public, private_key} = :crypto.generate_key(:ecdh, :prime256v1)
    new_iv = :crypto.strong_rand_bytes(12)
    {ciphertext, tag} = :crypto.crypto_one_time_aead(:chacha20_poly1305, server.api_key, new_iv, my_public, <<id::big-unsigned-32>>, 16, true)
    Logger.debug("Sending public key")
    :gen_tcp.send(client, new_iv <> tag <> ciphertext)

    send self(), {:connected, server.id}

    session_key = :crypto.compute_key(:ecdh, public_key, private_key, :prime256v1)
    {:noreply, %{server_id: server.id, socket: client, session_key: :crypto.hash(:sha512, session_key)}}
  end

  def handle_info({:tcp, client, data}, %{server_id: server_id, session_key: session_key} = state) do
    :inet.setopts(client, [active: :once])
    
    <<iv::binary-size(12), tag::binary-size(16), ciphertext::binary>> = data
    <<body::binary>> = :crypto.crypto_one_time_aead(:chacha20_poly1305, session_key, iv, ciphertext, <<server_id::big-unsigned-32>>, tag, false)
    send self(), {:decrypted, body}

    {:noreply, %{state | socket: client}}
  end

  def handle_info({:tcp_closed, _client}, state) do
    {:stop, :socket_closed, state}
  end

  def handle_info({:tcp_error, _client}, state) do
    {:stop, :socket_error, state}
  end
end