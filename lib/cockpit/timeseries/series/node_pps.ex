defmodule Cockpit.Timeseries.Series.NodePPS do
  use Instream.Series

  series do
    database "cockpit_nodes"
    measurement "pps"

    tag :server_id
    field :pps
  end

  def create(server_id, pps) do
    data = %__MODULE__{}
    data = %{data | fields: %{data.fields | pps: pps}}
    %{data | tags: %{data.tags | server_id: server_id}}
  end
end
