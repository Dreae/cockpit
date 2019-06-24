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
      Emails.send_finish_registration(Routes.account_recovery_url(conn, :get_password_reset, token.token), user)
    end

    conn
    |> put_flash(:info, "If that account exists a recovery email as been sent")
    |> render("recover_account.html")
  end

  def get_password_reset(conn, %{"token" => token}) do
    # TODO: Handle invalid token
    token = Accounts.get_password_reset!(token)
    render(conn, "reset_password.html", token: token)
  end
end
