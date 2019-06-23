defmodule Cockpit.Sessions.Session do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cockpit.Accounts.User

  schema "sessions" do
    field :sid, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:sid, :user_id])
    |> validate_required([:sid, :user_id])
  end
end
