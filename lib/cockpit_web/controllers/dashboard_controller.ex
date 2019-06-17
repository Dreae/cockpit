defmodule CockpitWeb.DashboardController do
    use CockpitWeb, :controller

    alias Cockpit.Servers
    alias Cockpit.GameServers

    def index(conn, _params) do
        total_servers = Servers.count_servers()
        connected_servers = Servers.count_connected_servers()
        game_servers = GameServers.count_game_servers()
        conn
        |> assign(:active_link, :index)
        |> render("index.html", %{total_servers: total_servers, game_servers: game_servers, connected_servers: connected_servers})
    end
end
