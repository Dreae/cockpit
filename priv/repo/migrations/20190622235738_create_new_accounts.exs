defmodule Cockpit.Repo.Migrations.CreateNewAccounts do
  use Ecto.Migration

  def change do
    create table(:new_accounts) do
      add :token, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:new_accounts, [:token, :user_id])
  end
end
