defmodule CockpitWeb.DashboardController do
    use CockpitWeb, :controller
    def index(conn, _params) do
        render conn, "index.html"
    end
end