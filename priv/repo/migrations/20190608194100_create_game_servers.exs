defmodule Cockpit.Repo.Migrations.CreateGameServers do
  use Ecto.Migration

  def change do
    create table(:game_servers) do
      add :bind, :string
      add :dest, :string
      add :internal_ip, :string
      add :a2s_info_cache, :integer
      add :cache_time, :integer

      timestamps()
    end

  end
end
