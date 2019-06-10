defmodule CockpitWeb.NodeController do
  use CockpitWeb, :controller

  alias Cockpit.Servers

  def index(conn, _params) do
    servers = Servers.list_servers()
    conn
    |> assign(:active_link, :node_list)
    |> render("index.html", servers: servers)
  end

  def reboot(conn, _params) do
    redirect conn, to: Routes.node_path(conn, :index)
  end
end