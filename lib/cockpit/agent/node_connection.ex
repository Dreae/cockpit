defmodule Cockpit.Agent.NodeConnection do
  use GenServer
  require Logger
  alias Cockpit.Servers

  def start_link(client) do
    GenServer.start_link(__MODULE__, client)
  end

  def init(client) do
    :inet.setopts(client, [active: :once])
    {:ok, %{server_id: nil, socket: client}}
  end

  def handle_info({:tcp, client, data}, %{server_id: nil}) do
    :inet.setopts(client, [active: :once])
    Logger.debug("Received join message from new socket")

    <<id::big-unsigned-32, signature::binary-size(16)>> = data
    server = Servers.get_server!(id)
    computed_sig = :crypto.hmac(:sha512, <<id::big-unsigned-32>>, to_charlist(server.api_key), 16)
    ^signature = computed_sig
    
    {:noreply, %{server_id: server.id, socket: client}}
  end

  def handle_info({:tcp, client, data}, %{server_id: server_id} = state) do
    :inet.setopts(client, [active: :once])
    Logger.debug("Got message from Server:#{server_id}")
    
    :gen_tcp.send(client, data)

    {:noreply, %{state | socket: client}}
  end

  def handle_info({:tcp_closed, _client}, state) do
    {:stop, :socket_closed, state}
  end

  def handle_info({:tcp_error, state}) do
    {:stop, :socket_error, state}
  end
end
