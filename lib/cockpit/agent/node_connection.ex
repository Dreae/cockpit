defmodule Cockpit.Agent.NodeConnection do
  use GenServer
  use Cockpit.Agent.EncryptedSocket
  require Logger

  def start_link(client) do
    GenServer.start_link(__MODULE__, client)
  end

  def init(client) do
    :inet.setopts(client, [active: :once])
    {:ok, %{server_id: nil, socket: client}}
  end

  def handle_info({:decrypted, "ping"}, %{server_id: id} = state) do
    send_encrypted('pong', state)

    {:noreply, state}
  end

  def handle_info({:decrypted, <<"pps", _pps::big-unsigned-32>>}, state) do
    {:noreply, state}
  end
end
