defmodule Cockpit.AccountsTest do
  use Cockpit.DataCase

  alias Cockpit.Accounts

  describe "users" do
    alias Cockpit.Accounts.User

    @valid_attrs %{email: "some email", password: "some password", username: "some username"}
    @update_attrs %{email: "some updated email", password: "some updated password", username: "some updated username"}
    @invalid_attrs %{email: nil, password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password == "some password"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password == "some updated password"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "validation_token" do
    alias Cockpit.Accounts.ValidationTokens

    @valid_attrs %{expires: ~N[2010-04-17 14:00:00], token: "some token"}
    @update_attrs %{expires: ~N[2011-05-18 15:01:01], token: "some updated token"}
    @invalid_attrs %{expires: nil, token: nil}

    def validation_tokens_fixture(attrs \\ %{}) do
      {:ok, validation_tokens} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_validation_tokens()

      validation_tokens
    end

    test "list_validation_token/0 returns all validation_token" do
      validation_tokens = validation_tokens_fixture()
      assert Accounts.list_validation_token() == [validation_tokens]
    end

    test "get_validation_tokens!/1 returns the validation_tokens with given id" do
      validation_tokens = validation_tokens_fixture()
      assert Accounts.get_validation_tokens!(validation_tokens.id) == validation_tokens
    end

    test "create_validation_tokens/1 with valid data creates a validation_tokens" do
      assert {:ok, %ValidationTokens{} = validation_tokens} = Accounts.create_validation_tokens(@valid_attrs)
      assert validation_tokens.expires == ~N[2010-04-17 14:00:00]
      assert validation_tokens.token == "some token"
    end

    test "create_validation_tokens/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_validation_tokens(@invalid_attrs)
    end

    test "update_validation_tokens/2 with valid data updates the validation_tokens" do
      validation_tokens = validation_tokens_fixture()
      assert {:ok, %ValidationTokens{} = validation_tokens} = Accounts.update_validation_tokens(validation_tokens, @update_attrs)
      assert validation_tokens.expires == ~N[2011-05-18 15:01:01]
      assert validation_tokens.token == "some updated token"
    end

    test "update_validation_tokens/2 with invalid data returns error changeset" do
      validation_tokens = validation_tokens_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_validation_tokens(validation_tokens, @invalid_attrs)
      assert validation_tokens == Accounts.get_validation_tokens!(validation_tokens.id)
    end

    test "delete_validation_tokens/1 deletes the validation_tokens" do
      validation_tokens = validation_tokens_fixture()
      assert {:ok, %ValidationTokens{}} = Accounts.delete_validation_tokens(validation_tokens)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_validation_tokens!(validation_tokens.id) end
    end

    test "change_validation_tokens/1 returns a validation_tokens changeset" do
      validation_tokens = validation_tokens_fixture()
      assert %Ecto.Changeset{} = Accounts.change_validation_tokens(validation_tokens)
    end
  end

  describe "password_resets" do
    alias Cockpit.Accounts.PasswordReset

    @valid_attrs %{token: "some token"}
    @update_attrs %{token: "some updated token"}
    @invalid_attrs %{token: nil}

    def password_reset_fixture(attrs \\ %{}) do
      {:ok, password_reset} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_password_reset()

      password_reset
    end

    test "list_password_resets/0 returns all password_resets" do
      password_reset = password_reset_fixture()
      assert Accounts.list_password_resets() == [password_reset]
    end

    test "get_password_reset!/1 returns the password_reset with given id" do
      password_reset = password_reset_fixture()
      assert Accounts.get_password_reset!(password_reset.id) == password_reset
    end

    test "create_password_reset/1 with valid data creates a password_reset" do
      assert {:ok, %PasswordReset{} = password_reset} = Accounts.create_password_reset(@valid_attrs)
      assert password_reset.token == "some token"
    end

    test "create_password_reset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_password_reset(@invalid_attrs)
    end

    test "update_password_reset/2 with valid data updates the password_reset" do
      password_reset = password_reset_fixture()
      assert {:ok, %PasswordReset{} = password_reset} = Accounts.update_password_reset(password_reset, @update_attrs)
      assert password_reset.token == "some updated token"
    end

    test "update_password_reset/2 with invalid data returns error changeset" do
      password_reset = password_reset_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_password_reset(password_reset, @invalid_attrs)
      assert password_reset == Accounts.get_password_reset!(password_reset.id)
    end

    test "delete_password_reset/1 deletes the password_reset" do
      password_reset = password_reset_fixture()
      assert {:ok, %PasswordReset{}} = Accounts.delete_password_reset(password_reset)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_password_reset!(password_reset.id) end
    end

    test "change_password_reset/1 returns a password_reset changeset" do
      password_reset = password_reset_fixture()
      assert %Ecto.Changeset{} = Accounts.change_password_reset(password_reset)
    end
  end

  describe "new_accounts" do
    alias Cockpit.Accounts.NewAccountToken

    @valid_attrs %{token: "some token"}
    @update_attrs %{token: "some updated token"}
    @invalid_attrs %{token: nil}

    def new_account_token_fixture(attrs \\ %{}) do
      {:ok, new_account_token} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_new_account_token()

      new_account_token
    end

    test "list_new_accounts/0 returns all new_accounts" do
      new_account_token = new_account_token_fixture()
      assert Accounts.list_new_accounts() == [new_account_token]
    end

    test "get_new_account_token!/1 returns the new_account_token with given id" do
      new_account_token = new_account_token_fixture()
      assert Accounts.get_new_account_token!(new_account_token.id) == new_account_token
    end

    test "create_new_account_token/1 with valid data creates a new_account_token" do
      assert {:ok, %NewAccountToken{} = new_account_token} = Accounts.create_new_account_token(@valid_attrs)
      assert new_account_token.token == "some token"
    end

    test "create_new_account_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_new_account_token(@invalid_attrs)
    end

    test "update_new_account_token/2 with valid data updates the new_account_token" do
      new_account_token = new_account_token_fixture()
      assert {:ok, %NewAccountToken{} = new_account_token} = Accounts.update_new_account_token(new_account_token, @update_attrs)
      assert new_account_token.token == "some updated token"
    end

    test "update_new_account_token/2 with invalid data returns error changeset" do
      new_account_token = new_account_token_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_new_account_token(new_account_token, @invalid_attrs)
      assert new_account_token == Accounts.get_new_account_token!(new_account_token.id)
    end

    test "delete_new_account_token/1 deletes the new_account_token" do
      new_account_token = new_account_token_fixture()
      assert {:ok, %NewAccountToken{}} = Accounts.delete_new_account_token(new_account_token)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_new_account_token!(new_account_token.id) end
    end

    test "change_new_account_token/1 returns a new_account_token changeset" do
      new_account_token = new_account_token_fixture()
      assert %Ecto.Changeset{} = Accounts.change_new_account_token(new_account_token)
    end
  end
end
