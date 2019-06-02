defmodule Cockpit.Accounts.ValidationTokens do
  use Ecto.Schema
  import Ecto.Changeset

  schema "validation_token" do
    field :expires, :naive_datetime
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(validation_tokens, attrs) do
    validation_tokens
    |> cast(attrs, [:token, :expires])
    |> validate_required([:token, :expires])
  end
end
