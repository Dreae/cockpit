defmodule CockpitWeb.UserController do
  use CockpitWeb, :controller

  alias Cockpit.Accounts
  alias Cockpit.Accounts.User
  alias Cockpit.Emails

  def index(conn, _params) do
    users = Accounts.list_users()
    conn
    |> assign(:active_link, :user_list)
    |> render("index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    conn
    |> assign(:active_link, :add_user)
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        if %{"send_email" => "true"} = user_params do
          {:ok, token} = Accounts.new_registration(user.id)
          Emails.send_finish_registration(Routes.new_registration_url(conn, :new_registration, token.token), user)
        end
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
