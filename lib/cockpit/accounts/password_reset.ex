defmodule Cockpit.Accounts.PasswordReset do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cockpit.Accounts.User

  schema "password_resets" do
    field :token, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(password_reset, attrs) do
    password_reset
    |> cast(attrs, [:token, :user_id])
    |> validate_required([:token, :user_id])
  end
end
