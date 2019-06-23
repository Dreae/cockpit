defmodule Cockpit.Accounts.NewAccountToken do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cockpit.Accounts.User

  schema "new_accounts" do
    field :token, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(new_account_token, attrs) do
    new_account_token
    |> cast(attrs, [:token, :user_id])
    |> validate_required([:token, :user_id])
  end
end
