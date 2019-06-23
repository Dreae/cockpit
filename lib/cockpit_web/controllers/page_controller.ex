defmodule CockpitWeb.PageController do
  use CockpitWeb, :controller

  alias Cockpit.Accounts
  alias Cockpit.Sessions

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def get_login(conn, _params) do
    if conn.assigns[:user] != nil do
      redirect(conn, to: Routes.page_path(conn, :index))
    else
      render(conn, "login.html")
    end
  end

  def do_login(conn, %{"username" => username, "password" => password}) do
    user = Accounts.get_user_by_email(username)
    cond do
      user == nil ->
        conn
        |> put_flash(:error, "Username or password incorrect")
        |> render("login.html")
      Argon2.verify_pass(password, user.password) == false ->
        conn
        |> put_flash(:error, "Username or password incorrect")
        |> render("login.html")
      true ->
        {:ok, session} = Sessions.new_session(user.id)
        conn
        |> put_session(:sid, session.sid)
        |> redirect(to: Routes.dashboard_path(conn, :index))
    end
  end

  def do_logout(conn, _params) do
    session = conn.assigns[:session]
    Sessions.delete_session(session)

    conn
    |> put_session(:sid, nil)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def get_account_settings(conn, _params) do
    changeset = Accounts.change_user(conn.assigns[:current_user])
    render(conn, "user_settings.html", changeset: changeset)
  end

  def update_account_settings(conn, %{"user" => user_params}) do
    safe_params = user_params
      |> Map.delete("level")
      |> Map.delete("username")

    password_match = case safe_params do
      %{"current_password" => ""} ->
        true
      %{"current_password" => password} ->
        Argon2.verify_pass(password, conn.assigns[:current_user].password)
      _ ->
        false
    end

    if password_match do
      case Accounts.update_user(conn.assigns[:current_user], safe_params) do
        {:ok, user} ->
          changeset = Accounts.change_user(user)
          conn
          |> put_flash(:info, "User updated successfully.")
          |> render("user_settings.html", changeset: changeset)

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "user_settings.html", changeset: changeset)
      end
    else
      changeset = Accounts.change_user(conn.assigns[:current_user])
        |> Ecto.Changeset.add_error(:current_password, "incorrect password")

      render(conn, "user_settings.html", changeset: changeset)
    end
  end
end
