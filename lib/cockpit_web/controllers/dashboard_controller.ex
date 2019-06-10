defmodule CockpitWeb.DashboardController do
    use CockpitWeb, :controller

    def index(conn, _params) do
        conn
        |> assign(:active_link, :index)
        |> render("index.html")
    end
end
