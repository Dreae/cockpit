defmodule CockpitWeb.Plugs.VerifyAdmin do
    import Phoenix.Controller

    def init(_params) do
        
    end

    def call(conn, _params) do
        if !Ecto.assoc_loaded?(conn.assigns[:user].admin) do
            conn
            |> put_flash(:error, "You can't access that page")
            |> redirect(to: "/")
        else
            conn
        end
    end
end