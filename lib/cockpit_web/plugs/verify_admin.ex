defmodule CockpitWeb.Plugs.VerifyAdmin do
    use CockpitWeb, :controller

    def init(_params) do

    end

    def call(conn, _params) do
        case conn.assigns[:user].level do
            :admin ->
                conn
            _ ->
                conn
                |> put_flash(:error, "You don't have access to this page")
                |> redirect(to: Routes.page_path(conn, :index))
        end
    end
end
