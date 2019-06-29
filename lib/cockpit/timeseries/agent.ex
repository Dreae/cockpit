defmodule Cockpit.Timeseries.Agent do
  use GenServer
  alias Cockpit.Timeseries.Connection
  alias Cockpit.Timeseries.Series.NodePPS

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: Cockpit.Timeseries.Agent)
  end

  def init(_) do
    :pong = Connection.ping()
    %{results: _} = Connection.execute("CREATE DATABASE cockpit_nodes", method: :post)
    {:ok, nil}
  end

  def handle_info({:current_pps, from}, state) do
    %{results: [%{series: [series]}]} = Connection.query("SELECT MEAN(pps) FROM pps WHERE time >= now() - 20s", database: :cockpit_nodes)
    case series do
      %{columns: ["time", "mean"], values: [value]} ->
        send(from, {:current_pps, Enum.at(value, 1)})
    end
    {:noreply, state}
  end

  def handle_info(%{server_id: id, pps: pps}, state) do
    data = NodePPS.create(id, pps)
    Connection.write(data)

    {:noreply, state}
  end
end
