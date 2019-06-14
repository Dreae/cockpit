defmodule Cockpit.Repo.Migrations.AddServerPorts do
  use Ecto.Migration

  def change do
    alter table(:game_servers) do
      add :bind_port, :integer, null: false
      add :dest_port, :integer, null: false
    end
  end
end
