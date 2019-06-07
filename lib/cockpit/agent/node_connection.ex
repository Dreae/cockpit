defmodule Cockpit.Agent.NodeConnection do
  def serve(client) do
    :inet.setopts(client, [active: :once])
    receive do
      msg ->
        case Cockpit.Agent.NodeConnection.handle_info(msg) do
          :ok ->
            serve(client)
          result ->
            result
        end
    end
  end

  def handle_info({:tcp, client, data}) do
    :gen_tcp.send(client, data)
    
    :ok
  end

  def handle_info({:tcp_closed, _client}) do
    {:shutdown, "Socket closed"}
  end

  def handle_info({:tcp_error, _client}) do
    {:shutdown, "Socket error"}
  end
end
