defmodule CockpitWeb.Plugs.Authorize do
  use CockpitWeb, :controller

  def init(level), do: level

  def call(conn, level) do
    if conn.assigns[:current_user].level ~> level do
      conn
    else
      conn
      |> put_flash(:error, "You don't have access to this page")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def a ~> b do
    case {a, b} do
      {:admin, _} ->
        true
      {:manager, :manager} ->
        true
      _ ->
        false
    end
  end
end
