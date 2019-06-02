defmodule Cockpit.ServersTest do
  use Cockpit.DataCase

  alias Cockpit.Servers

  describe "servers" do
    alias Cockpit.Servers.Server

    @valid_attrs %{address: "some address", api_key: "some api_key", name: "some name", port: 42}
    @update_attrs %{address: "some updated address", api_key: "some updated api_key", name: "some updated name", port: 43}
    @invalid_attrs %{address: nil, api_key: nil, name: nil, port: nil}

    def server_fixture(attrs \\ %{}) do
      {:ok, server} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Servers.create_server()

      server
    end

    test "list_servers/0 returns all servers" do
      server = server_fixture()
      assert Servers.list_servers() == [server]
    end

    test "get_server!/1 returns the server with given id" do
      server = server_fixture()
      assert Servers.get_server!(server.id) == server
    end

    test "create_server/1 with valid data creates a server" do
      assert {:ok, %Server{} = server} = Servers.create_server(@valid_attrs)
      assert server.address == "some address"
      assert server.api_key == "some api_key"
      assert server.name == "some name"
      assert server.port == 42
    end

    test "create_server/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Servers.create_server(@invalid_attrs)
    end

    test "update_server/2 with valid data updates the server" do
      server = server_fixture()
      assert {:ok, %Server{} = server} = Servers.update_server(server, @update_attrs)
      assert server.address == "some updated address"
      assert server.api_key == "some updated api_key"
      assert server.name == "some updated name"
      assert server.port == 43
    end

    test "update_server/2 with invalid data returns error changeset" do
      server = server_fixture()
      assert {:error, %Ecto.Changeset{}} = Servers.update_server(server, @invalid_attrs)
      assert server == Servers.get_server!(server.id)
    end

    test "delete_server/1 deletes the server" do
      server = server_fixture()
      assert {:ok, %Server{}} = Servers.delete_server(server)
      assert_raise Ecto.NoResultsError, fn -> Servers.get_server!(server.id) end
    end

    test "change_server/1 returns a server changeset" do
      server = server_fixture()
      assert %Ecto.Changeset{} = Servers.change_server(server)
    end
  end
end
