defmodule CockpitWeb.Plugs.LoginRequired do
    import Plug.Conn
    import Phoenix.Controller
    alias Cockpit.Accounts

    def init(_params) do
        
    end

    def call(conn, _params) do
        user = conn.assigns[:user]
        if user === nil do
            conn
            |> put_flash(:info, "You must be logged in.")
            |> redirect(to: "/")
        else
            conn
        end
    end
end