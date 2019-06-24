defmodule CockpitWeb.AccountRecoveryController do
  use CockpitWeb, :controller

  alias Cockpit.Emails
  alias Cockpit.Accounts

  def get_forgotten_password(conn, _params) do
    render(conn, "recover_account.html")
  end

  def do_recover_password(conn, %{"email_address" => email}) do
    user = Accounts.get_user_by_email(email)
    if user !== nil do
      {:ok, token} = Accounts.new_password_reset(user.id)
      Emails.send_password_recovery(Routes.account_recovery_url(conn, :get_password_reset, token.token), user)
    end

    conn
    |> put_flash(:info, "If that account exists a recovery email has been sent")
    |> render("recover_account.html")
  end

  def get_password_reset(conn, %{"token" => token}) do
    # TODO: Handle invalid token
    token = Accounts.get_password_reset!(token)
    changeset = Accounts.change_user(token.user)
    render(conn, "reset_password.html", token: token, changeset: changeset)
  end

  def do_password_reset(conn, %{"token" => token, "user" => user_params}) do
    token = Accounts.get_password_reset!(token)
    %{"password" => password, "password_confirmation" => conf} = user_params
    case Accounts.update_user(token.user, %{password: password, password_confirmation: conf}) do
      {:ok, _user} ->
        Accounts.finish_password_reset(token.user)
        redirect(conn, to: Routes.page_path(conn, :get_login))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "reset_password.html", token: token, changeset: changeset)
    end
  end
end
