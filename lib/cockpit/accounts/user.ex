defmodule Cockpit.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string
    field :level, Cockpit.AtomType

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :level])
    |> validate_required([:username, :email, :password, :level])
    |> validate_inclusion(:level, [:admin, :user])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
