defmodule CockpitWeb.DashboardController do
    use CockpitWeb, :controller

    def index(conn, _params) do
        conn 
        |> assign(:admin_template, "index.html")
        |> assign(:active_link, :index)
        |> render "layout.html"
    end
end