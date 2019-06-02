defmodule Cockpit.Servers.Server do
  use Ecto.Schema
  import Ecto.Changeset

  schema "servers" do
    field :address, :string
    field :api_key, :string
    field :name, :string
    field :port, :integer

    timestamps()
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:name, :address, :port, :api_key])
    |> validate_required([:name, :address, :port, :api_key])
  end
end
