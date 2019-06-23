defmodule Cockpit.Accounts.PasswordReset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "password_resets" do
    field :token, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(password_reset, attrs) do
    password_reset
    |> cast(attrs, [:token])
    |> validate_required([:token])
  end
end
