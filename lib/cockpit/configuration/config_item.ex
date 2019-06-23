defmodule Cockpit.Configuration.ConfigItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "config" do
    field :key, :string
    field :value, :binary

    timestamps()
  end

  @doc false
  def changeset(config_item, attrs) do
    config_item
    |> cast(attrs, [:key, :value])
    |> validate_required([:key, :value])
    |> unique_constraint(:key)
  end
end
