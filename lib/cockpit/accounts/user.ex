defmodule Cockpit.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cockpit.Ecto.Atom

  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string
    field :level, Atom

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :level])
    |> validate_required([:username, :email, :password, :level])
    |> validate_inclusion(:level, [:admin, :manager, :user])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_confirmation(:password)
    |> hash_password()
  end

  def changeset_no_passwd(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :level])
    |> validate_required([:username, :email, :level])
    |> validate_inclusion(:level, [:admin, :user])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> delete_change(:password)
  end

  def hash_password(user) do
    case user do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(user, :password, Argon2.hash_pwd_salt(pass))
      _ ->
        user
    end
  end
end
