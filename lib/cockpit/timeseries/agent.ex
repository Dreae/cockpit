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

  def handle_call(:get_pps_by_server, _from, state) do
    %{results: [%{series: series_list}]} = Connection.query("SELECT MEAN(pps) FROM pps WHERE time >= now() - 20s GROUP BY server_id", database: :cockpit_nodes)
    server_list = Enum.reduce(series_list, %{}, fn series, acc ->
      %{tags: %{server_id: id}, values: [[_time, pps]]} = series
      Map.put(acc, id, pps)
    end)

    {:reply, server_list, state}
  end

  def handle_info({:current_pps, from}, state) do
    %{results: [%{series: [series]}]} = Connection.query("SELECT MEAN(pps) FROM pps WHERE time >= now() - 20s", database: :cockpit_nodes)
    case series do
      %{columns: ["time", "mean"], values: [value]} ->
        time = Enum.at(value, 0)
        pps = Enum.at(value, 1)
        send(from, {:current_pps, %{time: time, pps: pps}})
    end
    {:noreply, state}
  end

  def handle_info(%{server_id: id, pps: pps}, state) do
    data = NodePPS.create(id, pps)
    Connection.write(data)

    {:noreply, state}
  end

  def handle_info({:pps_summary, from}, state) do
    %{results: [%{series: [series]}]} = Connection.query("SELECT MEAN(pps) FROM pps WHERE time >= now() - 30m GROUP BY time(20s)", database: :cockpit_nodes)
    send(from, {:pps_summary, series})
    {:noreply, state}
  end

  def get_pps_by_server_id() do
    GenServer.call(Cockpit.Timeseries.Agent, :get_pps_by_server)
  end
end
