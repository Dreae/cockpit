defmodule CockpitWeb.PageController do
  use CockpitWeb, :controller

  alias Cockpit.Accounts

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def get_login(conn, _params) do
    if conn.assigns[:user] != nil do
      redirect(conn, to: "/")
    else
      render(conn, "login.html")
    end
  end

  def do_login(conn, %{"username" => username, "password" => password}) do
    user = Accounts.get_user_by_username(username)
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
        conn
        |> put_session(:user_id, user.id)
        |> redirect(to: "/")
    end
  end
end
