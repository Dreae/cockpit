defmodule Cockpit.Ecto.IPv4 do
  @behaviour Ecto.Type

  def type, do: :string

  def cast(value) when is_tuple(value), do: {:ok, value}

  def cast(value) when is_binary(value) do
    __MODULE__.load(value)
  end

  def load(value) do
    value
    |> to_charlist()
    |> :inet.parse_ipv4_address()
  end

  def dump(value) when is_tuple(value) do
    ip = value
      |> :inet.ntoa()
      |> to_string()
    {:ok, ip}
  end

  def dump(_), do: :error
end
