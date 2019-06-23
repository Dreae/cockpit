defmodule Cockpit.Accounts.NewAccountToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "new_accounts" do
    field :token, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(new_account_token, attrs) do
    new_account_token
    |> cast(attrs, [:token])
    |> validate_required([:token])
  end
end
