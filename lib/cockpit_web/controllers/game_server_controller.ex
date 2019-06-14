defmodule CockpitWeb.GameServerController do
  use CockpitWeb, :controller

  alias Cockpit.GameServers

  def index(conn, _params) do
    servers = GameServers.list_game_servers()
    conn
    |> assign(:active_link, :node_list)
    |> render("index.html", servers: servers)
  end

  def delete(conn, _params) do
    redirect conn, to: Routes.node_path(conn, :index)
  end
end