defmodule CockpitWeb.Plugs.LoginRequired do
    use CockpitWeb, :controller

    def init(_params) do

    end

    def call(conn, _params) do
        if conn.assigns[:current_user] === nil do
            conn
            |> put_flash(:info, "You must be logged in.")
            |> redirect(to: Routes.page_path(conn, :get_login))
        else
            conn
        end
    end
end
