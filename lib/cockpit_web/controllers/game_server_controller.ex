defmodule CockpitWeb.GameServerController do
  use CockpitWeb, :controller

  alias Cockpit.GameServers
  alias Cockpit.GameServers.GameServer

  def index(conn, _params) do
    servers = GameServers.list_game_servers()
    conn
    |> assign(:active_link, :server_list)
    |> render("index.html", servers: servers)
  end

  def edit(conn, %{"id" => id}) do
    game_server = GameServers.get_game_server!(id)
    changeset = GameServers.change_game_server(game_server)
    render(conn, "edit.html", game_server: game_server, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = GameServers.change_game_server(%GameServer{})
    conn
    |> assign(:active_link, :add_server)
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"game_server" => server_params}) do
    server_params = case server_params do
      %{"internal_ip" => "", "dest" => dest} ->
        %{server_params | "internal_ip" => dest}
      _ ->
        server_params
    end

    case GameServers.create_game_server(server_params) do
      {:ok, game_server} ->
        Phoenix.PubSub.broadcast(Cockpit.PubSub, "GameServers:updates", {:server_update, game_server})

        conn
        |> put_flash(:info, "Server created successfully.")
        |> redirect(to: Routes.game_server_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
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

  def delete(conn, %{"id" => id}) do
    game_server = GameServers.get_game_server!(id)
    {:ok, _server} = GameServers.delete_game_server(game_server)

    conn
    |> put_flash(:info, "Server deleted successfully.")
    |> redirect(to: Routes.game_server_path(conn, :index))
  end
end