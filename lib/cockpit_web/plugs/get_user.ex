defmodule CockpitWeb.Plugs.GetUser do
    import Plug.Conn
    alias Cockpit.Accounts

    def init(_params) do
        
    end

    def call(conn, _params) do
        user_id = get_session(conn, :user_id)
        if user_id !== nil do
            assign(conn, :user, Accounts.get_user!(user_id))
        else
            assign(conn, :user, nil)
        end
    end
end