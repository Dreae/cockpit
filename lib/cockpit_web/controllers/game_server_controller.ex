defmodule CockpitWeb.GameServerController do
  use CockpitWeb, :controller

  alias Cockpit.GameServers

  def index(conn, _params) do
    servers = GameServers.list_game_servers()
    conn
    |> assign(:active_link, :node_list)
    |> render("index.html", servers: servers)
  end

  def edit(conn, %{"id" => id}) do
    game_server = GameServers.get_game_server!(id)
    changeset = GameServers.change_game_server(game_server)
    render(conn, "edit.html", game_server: game_server, changeset: changeset)
  end

  def update(conn, %{"id" => id, "game_server" => server_params}) do
    game_server = GameServers.get_game_server!(id)

    case GameServers.update_game_server(game_server, server_params) do
      {:ok, game_server} ->
        Phoenix.PubSub.broadcast(Cockpit.PubSub, "GameServers:updates", {:server_update, game_server})

        conn
        |> put_flash(:info, "Server updated")
        |> redirect(to: Routes.game_server_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", game_server: game_server, changeset: changeset)
      end
  end

  def delete(conn, _params) do
    redirect conn, to: Routes.node_path(conn, :index)
  end
end