defmodule Cockpit.ConfigurationTest do
  use Cockpit.DataCase

  alias Cockpit.Configuration

  describe "config" do
    alias Cockpit.Configuration.ConfigItem

    @valid_attrs %{key: "some key", value: "some value"}
    @update_attrs %{key: "some updated key", value: "some updated value"}
    @invalid_attrs %{key: nil, value: nil}

    def config_item_fixture(attrs \\ %{}) do
      {:ok, config_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Configuration.create_config_item()

      config_item
    end

    test "list_config/0 returns all config" do
      config_item = config_item_fixture()
      assert Configuration.list_config() == [config_item]
    end

    test "get_config_item!/1 returns the config_item with given id" do
      config_item = config_item_fixture()
      assert Configuration.get_config_item!(config_item.id) == config_item
    end

    test "create_config_item/1 with valid data creates a config_item" do
      assert {:ok, %ConfigItem{} = config_item} = Configuration.create_config_item(@valid_attrs)
      assert config_item.key == "some key"
      assert config_item.value == "some value"
    end

    test "create_config_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Configuration.create_config_item(@invalid_attrs)
    end

    test "update_config_item/2 with valid data updates the config_item" do
      config_item = config_item_fixture()
      assert {:ok, %ConfigItem{} = config_item} = Configuration.update_config_item(config_item, @update_attrs)
      assert config_item.key == "some updated key"
      assert config_item.value == "some updated value"
    end

    test "update_config_item/2 with invalid data returns error changeset" do
      config_item = config_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Configuration.update_config_item(config_item, @invalid_attrs)
      assert config_item == Configuration.get_config_item!(config_item.id)
    end

    test "delete_config_item/1 deletes the config_item" do
      config_item = config_item_fixture()
      assert {:ok, %ConfigItem{}} = Configuration.delete_config_item(config_item)
      assert_raise Ecto.NoResultsError, fn -> Configuration.get_config_item!(config_item.id) end
    end

    test "change_config_item/1 returns a config_item changeset" do
      config_item = config_item_fixture()
      assert %Ecto.Changeset{} = Configuration.change_config_item(config_item)
    end
  end
end
