defmodule Cockpit.Repo.Migrations.CreateValidationTokenIndex do
  use Ecto.Migration

  def change do
    create index(:validation_token, [:token])
  end
end
