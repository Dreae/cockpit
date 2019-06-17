defmodule Cockpit.Repo.Migrations.AddNodeStatus do
  use Ecto.Migration

  def change do
    alter table(:servers) do
      add :status, :string, null: false, default: "down"
    end
  end
end
