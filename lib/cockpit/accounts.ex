defmodule Cockpit.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Cockpit.Repo

  alias Cockpit.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.one!(from u in User, where: u.id == ^id)

  @doc """
  Gets a single user by username.

  """
  def get_user_by_username(username) do
    Repo.one(from u in User, where: u.username == ^username)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Cockpit.Accounts.ValidationTokens

  @doc """
  Returns the list of validation_token.

  ## Examples

      iex> list_validation_token()
      [%ValidationTokens{}, ...]

  """
  def list_validation_token do
    Repo.all(ValidationTokens)
  end

  @doc """
  Gets a single validation_tokens.

  Raises `Ecto.NoResultsError` if the Validation tokens does not exist.

  ## Examples

      iex> get_validation_tokens!(123)
      %ValidationTokens{}

      iex> get_validation_tokens!(456)
      ** (Ecto.NoResultsError)

  """
  def get_validation_tokens!(id), do: Repo.get!(ValidationTokens, id)

  @doc """
  Creates a validation_tokens.

  ## Examples

      iex> create_validation_tokens(%{field: value})
      {:ok, %ValidationTokens{}}

      iex> create_validation_tokens(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_validation_tokens(attrs \\ %{}) do
    %ValidationTokens{}
    |> ValidationTokens.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a validation_tokens.

  ## Examples

      iex> update_validation_tokens(validation_tokens, %{field: new_value})
      {:ok, %ValidationTokens{}}

      iex> update_validation_tokens(validation_tokens, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_validation_tokens(%ValidationTokens{} = validation_tokens, attrs) do
    validation_tokens
    |> ValidationTokens.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ValidationTokens.

  ## Examples

      iex> delete_validation_tokens(validation_tokens)
      {:ok, %ValidationTokens{}}

      iex> delete_validation_tokens(validation_tokens)
      {:error, %Ecto.Changeset{}}

  """
  def delete_validation_tokens(%ValidationTokens{} = validation_tokens) do
    Repo.delete(validation_tokens)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking validation_tokens changes.

  ## Examples

      iex> change_validation_tokens(validation_tokens)
      %Ecto.Changeset{source: %ValidationTokens{}}

  """
  def change_validation_tokens(%ValidationTokens{} = validation_tokens) do
    ValidationTokens.changeset(validation_tokens, %{})
  end
end
