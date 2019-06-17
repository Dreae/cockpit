defmodule CockpitWeb.GameServerView do
  use CockpitWeb, :view

  defimpl Phoenix.HTML.Safe, for: Tuple do
    def to_iodata(data), do: data |> :inet.ntoa()
  end
end
