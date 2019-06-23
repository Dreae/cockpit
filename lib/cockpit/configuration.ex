defmodule Cockpit.Configuration do
  @moduledoc """
  The Configuration context.
  """

  import Ecto.Query, warn: false
  alias Cockpit.Repo

  alias Cockpit.Configuration.ConfigItem

  @doc """
  Returns the list of config.

  ## Examples

      iex> list_config()
      [%ConfigItem{}, ...]

  """
  def list_config do
    Repo.all(ConfigItem)
  end

  @doc """
  Gets a single config_item.

  Raises `Ecto.NoResultsError` if the Config item does not exist.

  ## Examples

      iex> get_config_item!(123)
      %ConfigItem{}

      iex> get_config_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_config_item!(id) do
    Repo.get_by!(ConfigItem, [key: id])
  end

  def get_config_item(id) do
    Repo.get_by(ConfigItem, [key: id])
  end

  @doc """
  Creates a config_item.

  ## Examples

      iex> create_config_item(%{field: value})
      {:ok, %ConfigItem{}}

      iex> create_config_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_config_item(attrs \\ %{}) do
    %ConfigItem{}
    |> ConfigItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a config_item.

  ## Examples

      iex> update_config_item(config_item, %{field: new_value})
      {:ok, %ConfigItem{}}

      iex> update_config_item(config_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_config_item(%ConfigItem{} = config_item, attrs) do
    config_item
    |> ConfigItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ConfigItem.

  ## Examples

      iex> delete_config_item(config_item)
      {:ok, %ConfigItem{}}

      iex> delete_config_item(config_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_config_item(%ConfigItem{} = config_item) do
    Repo.delete(config_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking config_item changes.

  ## Examples

      iex> change_config_item(config_item)
      %Ecto.Changeset{source: %ConfigItem{}}

  """
  def change_config_item(%ConfigItem{} = config_item) do
    ConfigItem.changeset(config_item, %{})
  end

  def get_value(key) do
    case get_config_item(key) do
      nil ->
        nil
      item ->
        item.value
    end
  end

  def set_value(key, value) do
    item = get_config_item(key)
    if item !== nil do
      update_config_item(item, %{value: value})
    else
      create_config_item(%{key: key, value: value})
    end
  end

  def unset_value(key) do
    Repo.delete_all(from(c in ConfigItem, where: c.key == ^key))
  end

  def get_sendgrid_key do
    get_value("SENDGRID_API_KEY")
  end

  def set_sendgrid_key(api_key) do
    set_value("SENDGRID_API_KEY", api_key)
  end

  def unset_sendgrid_key do
    unset_value("SENDGRID_API_KEY")
  end

  def get_from_address do
    get_value("SENDGRID_FROM_ADDRESS")
  end

  def set_from_address(from_address) do
    set_value("SENDGRID_FROM_ADDRESS", from_address)
  end

  def unset_from_address do
    unset_value("SENDGRID_FROM_ADDRESS")
  end
end
