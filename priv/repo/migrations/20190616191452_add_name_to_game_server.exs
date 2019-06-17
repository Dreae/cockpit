defmodule Cockpit.Repo.Migrations.AddNameToGameServer do
  use Ecto.Migration

  def change do
    alter table(:game_servers) do
      add :name, :string
    end

    create unique_index(:game_servers, [:name])
  end
end
