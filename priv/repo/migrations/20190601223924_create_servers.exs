defmodule Cockpit.Repo.Migrations.CreateServers do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add :name, :string
      add :address, :string
      add :port, :integer
      add :api_key, :string

      timestamps()
    end

  end
end
