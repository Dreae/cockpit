defmodule Cockpit.GameServers.GameServer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "game_servers" do
    field :a2s_info_cache, :integer
    field :bind, :string
    field :cache_time, :integer
    field :dest, :string
    field :internal_ip, :string

    timestamps()
  end

  @doc false
  def changeset(game_server, attrs) do
    game_server
    |> cast(attrs, [:bind, :dest, :internal_ip, :a2s_info_cache, :cache_time])
    |> validate_required([:bind, :dest, :internal_ip, :a2s_info_cache, :cache_time])
  end
end
