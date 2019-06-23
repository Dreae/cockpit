defmodule CockpitWeb.NewRegistrationController do
  use CockpitWeb, :controller

  alias Cockpit.Accounts

  # TODO: Handle invalid link
  def new_registration(conn, %{"token" => token}) do
    token = Accounts.get_new_account_token!(token)
    changeset = Accounts.change_user(token.user)
    render(conn, "index.html", user: token.user, token: token, changeset: changeset)
  end

  def finish_registration(conn, %{"token" => token, "user" => %{"password" => password, "password_confirmation" => password_conf}}) do
    token = Accounts.get_new_account_token!(token)
    case Accounts.update_user(token.user, %{password: password, password_confirmation: password_conf}) do
      {:ok, user} ->
        Accounts.finish_registration(token.user.id)
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", user: token.user, token: token, changeset: changeset)
    end
  end
end