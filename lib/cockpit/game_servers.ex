defmodule Cockpit.GameServers do
  @moduledoc """
  The GameServers context.
  """

  import Ecto.Query, warn: false
  alias Cockpit.Repo

  alias Cockpit.GameServers.GameServer

  @doc """
  Returns the list of game_servers.

  ## Examples

      iex> list_game_servers()
      [%GameServer{}, ...]

  """
  def list_game_servers do
    Repo.all(GameServer)
  end

  @doc """
  Gets a single game_server.

  Raises `Ecto.NoResultsError` if the Game server does not exist.

  ## Examples

      iex> get_game_server!(123)
      %GameServer{}

      iex> get_game_server!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game_server!(id), do: Repo.get!(GameServer, id)

  @doc """
  Creates a game_server.

  ## Examples

      iex> create_game_server(%{field: value})
      {:ok, %GameServer{}}

      iex> create_game_server(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game_server(attrs \\ %{}) do
    %GameServer{}
    |> GameServer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game_server.

  ## Examples

      iex> update_game_server(game_server, %{field: new_value})
      {:ok, %GameServer{}}

      iex> update_game_server(game_server, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game_server(%GameServer{} = game_server, attrs) do
    game_server
    |> GameServer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a GameServer.

  ## Examples

      iex> delete_game_server(game_server)
      {:ok, %GameServer{}}

      iex> delete_game_server(game_server)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game_server(%GameServer{} = game_server) do
    Repo.delete(game_server)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game_server changes.

  ## Examples

      iex> change_game_server(game_server)
      %Ecto.Changeset{source: %GameServer{}}

  """
  def change_game_server(%GameServer{} = game_server) do
    GameServer.changeset(game_server, %{})
  end

  def count_game_servers() do
    Repo.aggregate(from(s in "game_servers"), :count, :id)
  end
end
