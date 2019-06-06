defmodule Cockpit.Agent do
  alias Cockpit.Timeseries.Connection
  require Logger

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link(port) do
    :pong = Connection.ping()
    Cockpit.Timeseries.Connection.execute("CREATE DATABASE cockpit_nodes", method: :post)

    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    loop_accept(socket)
  end

  def loop_accept(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(Cockpit.Agent.Supervisor, fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)

    loop_accept(socket)
  end

  def serve(client) do
    :inet.setopts(client, [active: :once])
    receive do
      {:tcp, client, data} ->
        :gen_tcp.send(client, data)
        serve(client)
    end
  end
end
