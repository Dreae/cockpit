defmodule Cockpit.GameServersTest do
  use Cockpit.DataCase

  alias Cockpit.GameServers

  describe "game_servers" do
    alias Cockpit.GameServers.GameServer

    @valid_attrs %{a2s_info_cache: 42, bind: "some bind", cache_time: 42, dest: "some dest", internal_ip: "some internal_ip"}
    @update_attrs %{a2s_info_cache: 43, bind: "some updated bind", cache_time: 43, dest: "some updated dest", internal_ip: "some updated internal_ip"}
    @invalid_attrs %{a2s_info_cache: nil, bind: nil, cache_time: nil, dest: nil, internal_ip: nil}

    def game_server_fixture(attrs \\ %{}) do
      {:ok, game_server} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GameServers.create_game_server()

      game_server
    end

    test "list_game_servers/0 returns all game_servers" do
      game_server = game_server_fixture()
      assert GameServers.list_game_servers() == [game_server]
    end

    test "get_game_server!/1 returns the game_server with given id" do
      game_server = game_server_fixture()
      assert GameServers.get_game_server!(game_server.id) == game_server
    end

    test "create_game_server/1 with valid data creates a game_server" do
      assert {:ok, %GameServer{} = game_server} = GameServers.create_game_server(@valid_attrs)
      assert game_server.a2s_info_cache == 42
      assert game_server.bind == "some bind"
      assert game_server.cache_time == 42
      assert game_server.dest == "some dest"
      assert game_server.internal_ip == "some internal_ip"
    end

    test "create_game_server/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GameServers.create_game_server(@invalid_attrs)
    end

    test "update_game_server/2 with valid data updates the game_server" do
      game_server = game_server_fixture()
      assert {:ok, %GameServer{} = game_server} = GameServers.update_game_server(game_server, @update_attrs)
      assert game_server.a2s_info_cache == 43
      assert game_server.bind == "some updated bind"
      assert game_server.cache_time == 43
      assert game_server.dest == "some updated dest"
      assert game_server.internal_ip == "some updated internal_ip"
    end

    test "update_game_server/2 with invalid data returns error changeset" do
      game_server = game_server_fixture()
      assert {:error, %Ecto.Changeset{}} = GameServers.update_game_server(game_server, @invalid_attrs)
      assert game_server == GameServers.get_game_server!(game_server.id)
    end

    test "delete_game_server/1 deletes the game_server" do
      game_server = game_server_fixture()
      assert {:ok, %GameServer{}} = GameServers.delete_game_server(game_server)
      assert_raise Ecto.NoResultsError, fn -> GameServers.get_game_server!(game_server.id) end
    end

    test "change_game_server/1 returns a game_server changeset" do
      game_server = game_server_fixture()
      assert %Ecto.Changeset{} = GameServers.change_game_server(game_server)
    end
  end
end
