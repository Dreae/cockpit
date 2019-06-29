defmodule Cockpit.Agent do
  alias Cockpit.Timeseries.Connection
  use Task, restart: :permanent
  require Logger

  def start_link(port) do
      Task.start_link(Cockpit.Agent, :start_listen, [port])
  end

  def start_listen(port) do
    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: 2, active: false, reuseaddr: true])
    loop_accept(socket)
  end

  def loop_accept(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = DynamicSupervisor.start_child(Cockpit.Agent.Supervisor, {Cockpit.Agent.NodeConnection, client})
    :ok = :gen_tcp.controlling_process(client, pid)

    loop_accept(socket)
  end
end
