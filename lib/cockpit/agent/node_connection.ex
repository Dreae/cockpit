defmodule Cockpit.Agent.NodeConnection do
  use GenServer

  def start_link(client) do
    GenServer.start_link(__MODULE__, client)
  end

  def init(client) do
    :inet.setopts(client, [active: :once])
    {:ok, %{server_id: nil}}
  end

  def handle_info({:tcp, client, data}, %{server_id: nil}) do
    :gen_tcp.send(client, data)
    
    {:ok, %{server_id: nil}}
  end

  def handle_info({:tcp_closed, _client}, state) do
    {:stop, :socket_closed, state}
  end

  def handle_info({:tcp_error, state}) do
    {:stop, :socket_error, state}
  end
end
