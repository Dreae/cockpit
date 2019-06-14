defmodule CockpitWeb.GameServerView do
  use CockpitWeb, :view

  def ip_to_string(ip_addr) do
    :inet.ntoa(ip_addr)
  end
end