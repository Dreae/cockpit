defmodule Cockpit.Servers.Server do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cockpit.Ecto.Atom

  schema "servers" do
    field :address, :string
    field :api_key, :string
    field :name, :string
    field :port, :integer
    field :status, Atom, default: :down

    timestamps()
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:name, :address, :port, :api_key, :status])
    |> validate_required([:name, :address, :port, :api_key, :status])
    |> validate_inclusion(:status, [:up, :down])
    |> unique_constraint(:name)
  end
end
