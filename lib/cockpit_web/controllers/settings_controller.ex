defmodule CockpitWeb.SettingsController do
  use CockpitWeb, :controller

  alias Cockpit.Configuration

  def get_settings_page(conn, _params) do
    from_address = Configuration.get_from_address()
    api_key = Configuration.get_sendgrid_key()
    render(conn, "index.html", sendgrid_api_key: api_key, from_address: from_address)
  end

  def update_settings(conn, params) do
    case params do
      %{"from_address" => ""} ->
        Configuration.unset_from_address()
      %{"from_address" => address} ->
        Configuration.set_from_address(address)
    end

    case params do
      %{"sendgrid_api_key" => ""} ->
        Configuration.unset_sendgrid_key()
      %{"sendgrid_api_key" => key} ->
        Configuration.set_sendgrid_key(key)
    end
    
    from_address = Configuration.get_from_address()
    api_key = Configuration.get_sendgrid_key()
    render(conn, "index.html", sendgrid_api_key: api_key, from_address: from_address)
  end
end
