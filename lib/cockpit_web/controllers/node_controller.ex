defmodule CockpitWeb.NodeController do
  use CockpitWeb, :controller

  alias Ecto.Changeset
  alias Cockpit.Servers
  alias Cockpit.Servers.Server

  def index(conn, _params) do
    servers = Servers.list_servers()
    conn
    |> assign(:active_link, :node_list)
    |> render("index.html", servers: servers)
  end

  def new(conn, _params) do 
    changeset = Servers.change_server(%Server{}) |> Changeset.put_change(:api_key, Servers.gen_token())
    conn
    |> assign(:active_link, :add_node)
    |> assign(:changeset, changeset)
    |> render("new.html")
  end

  def create(conn, %{"server" => server_params}) do
    case Servers.create_server(server_params) do
      {:ok, _server} ->
        conn
        |> put_flash(:info, "Server created successfully.")
        |> redirect(to: Routes.node_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    node = Servers.get_server!(id)
    changeset = Servers.change_server(node)
    render(conn, "edit.html", node: node, changeset: changeset)
  end

  def reboot(conn, _params) do
    redirect conn, to: Routes.node_path(conn, :index)
  end
end