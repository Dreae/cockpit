defmodule Cockpit.Repo.Migrations.CreateValidationToken do
  use Ecto.Migration

  def change do
    create table(:validation_token) do
      add :token, :string
      add :expires, :naive_datetime

      timestamps()
    end

  end
end
