defmodule Cockpit.Emails do
  alias SendGrid.Email
  alias SendGrid.Mail

  def send_password_recovery(recovery_url, user) do
    api_key = Cockpit.Configuration.get_sendgrid_key()
    from_address = Cockpit.Configuration.get_from_address()
    if api_key !== nil and from_address != nil do
      {:ok, body} = File.read("priv/static/email__password_reset.html")

      Email.build()
      |> Email.put_subject("Cockpit - Password Recovery")
      |> Email.add_to(user.email)
      |> Email.put_from(from_address)
      |> Email.put_html(body)
      |> Email.add_substitution("-resetLink-", recovery_url)
      |> Mail.send(api_key: api_key)
    end
  end

  def send_finish_registration(registration_url, user) do
    api_key = Cockpit.Configuration.get_sendgrid_key()
    from_address = Cockpit.Configuration.get_from_address()
    if api_key !== nil and from_address != nil do
      {:ok, body} = File.read("priv/static/email__new_account.html")

      Email.build()
      |> Email.put_subject("Cockpit - Finish Registration")
      |> Email.add_to(user.email)
      |> Email.put_from(from_address)
      |> Email.put_html(body)
      |> Email.add_substitution("-signupLink-", registration_url)
      |> Email.add_substitution("-username-", user.username)
      |> Mail.send(api_key: api_key)
    end
  end
end