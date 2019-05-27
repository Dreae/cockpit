defmodule CockpitWeb.Plugs.VerifyAdmin do
    import Plug.Conn
    import Phoenix.Controller

    def init(_params) do
        
    end

    def call(conn, _params) do
        conn
        |> put_flash(:error, "You can't access that page")
        |> redirect(to: "/")
    end
end