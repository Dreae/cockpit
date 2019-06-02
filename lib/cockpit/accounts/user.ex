defmodule Cockpit.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cockpit.Admins.Admin

  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string
    has_one :admin, Admin

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
