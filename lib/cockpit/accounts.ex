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
  def get_user_by_email(email) do
    Repo.one(from u in User, where: u.email == ^email)
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
    attrs = case attrs do
      %{"password" => ""} ->
        Map.delete(attrs, "password") |> Map.delete("password_confirmation")
      _ ->
        attrs
    end
    
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

  alias Cockpit.Accounts.PasswordReset

  @doc """
  Returns the list of password_resets.

  ## Examples

      iex> list_password_resets()
      [%PasswordReset{}, ...]

  """
  def list_password_resets do
    Repo.all(PasswordReset)
  end

  @doc """
  Gets a single password_reset.

  Raises `Ecto.NoResultsError` if the Password reset does not exist.

  ## Examples

      iex> get_password_reset!(123)
      %PasswordReset{}

      iex> get_password_reset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_password_reset!(id), do: Repo.get!(PasswordReset, id)

  @doc """
  Creates a password_reset.

  ## Examples

      iex> create_password_reset(%{field: value})
      {:ok, %PasswordReset{}}

      iex> create_password_reset(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_password_reset(attrs \\ %{}) do
    %PasswordReset{}
    |> PasswordReset.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a password_reset.

  ## Examples

      iex> update_password_reset(password_reset, %{field: new_value})
      {:ok, %PasswordReset{}}

      iex> update_password_reset(password_reset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_password_reset(%PasswordReset{} = password_reset, attrs) do
    password_reset
    |> PasswordReset.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PasswordReset.

  ## Examples

      iex> delete_password_reset(password_reset)
      {:ok, %PasswordReset{}}

      iex> delete_password_reset(password_reset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_password_reset(%PasswordReset{} = password_reset) do
    Repo.delete(password_reset)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking password_reset changes.

  ## Examples

      iex> change_password_reset(password_reset)
      %Ecto.Changeset{source: %PasswordReset{}}

  """
  def change_password_reset(%PasswordReset{} = password_reset) do
    PasswordReset.changeset(password_reset, %{})
  end

  alias Cockpit.Accounts.NewAccountToken

  @doc """
  Returns the list of new_accounts.

  ## Examples

      iex> list_new_accounts()
      [%NewAccountToken{}, ...]

  """
  def list_new_accounts do
    Repo.all(NewAccountToken)
  end

  @doc """
  Gets a single new_account_token.

  Raises `Ecto.NoResultsError` if the New account token does not exist.

  ## Examples

      iex> get_new_account_token!(123)
      %NewAccountToken{}

      iex> get_new_account_token!(456)
      ** (Ecto.NoResultsError)

  """
  def get_new_account_token!(id), do: Repo.get!(NewAccountToken, id)

  @doc """
  Creates a new_account_token.

  ## Examples

      iex> create_new_account_token(%{field: value})
      {:ok, %NewAccountToken{}}

      iex> create_new_account_token(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_new_account_token(attrs \\ %{}) do
    %NewAccountToken{}
    |> NewAccountToken.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a new_account_token.

  ## Examples

      iex> update_new_account_token(new_account_token, %{field: new_value})
      {:ok, %NewAccountToken{}}

      iex> update_new_account_token(new_account_token, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_new_account_token(%NewAccountToken{} = new_account_token, attrs) do
    new_account_token
    |> NewAccountToken.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a NewAccountToken.

  ## Examples

      iex> delete_new_account_token(new_account_token)
      {:ok, %NewAccountToken{}}

      iex> delete_new_account_token(new_account_token)
      {:error, %Ecto.Changeset{}}

  """
  def delete_new_account_token(%NewAccountToken{} = new_account_token) do
    Repo.delete(new_account_token)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking new_account_token changes.

  ## Examples

      iex> change_new_account_token(new_account_token)
      %Ecto.Changeset{source: %NewAccountToken{}}

  """
  def change_new_account_token(%NewAccountToken{} = new_account_token) do
    NewAccountToken.changeset(new_account_token, %{})
  end
end
