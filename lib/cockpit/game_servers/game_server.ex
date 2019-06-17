defmodule Cockpit.GameServers.GameServer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cockpit.Ecto.IPv4

  schema "game_servers" do
    field :name, :string
    field :a2s_info_cache, :integer
    field :bind, IPv4
    field :bind_port, :integer
    field :cache_time, :integer
    field :dest, IPv4
    field :dest_port, :integer
    field :internal_ip, IPv4

    timestamps()
  end

  @doc false
  def changeset(game_server, attrs) do
    game_server
    |> cast(attrs, [:bind, :dest, :internal_ip, :a2s_info_cache, :cache_time, :bind_port, :dest_port, :name])
    |> validate_required([:bind, :dest, :internal_ip, :a2s_info_cache, :cache_time, :bind_port, :dest_port, :name])
    |> validate_inclusion(:bind_port, 0..65535)
    |> validate_inclusion(:dest_port, 0..65535)
    |> unique_constraint(:name)
  end
end
