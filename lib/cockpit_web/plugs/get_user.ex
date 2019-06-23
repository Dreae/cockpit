defmodule CockpitWeb.Plugs.GetUser do
    use CockpitWeb, :controller
    alias Cockpit.Sessions

    def init(_params) do

    end

    def call(conn, _params) do
        if conn.assigns[:session] do
            conn
        else
            sid = get_session(conn, :sid)
            if sid !== nil do
                session = Sessions.get_session!(sid)
                conn
                |> assign(:session, session)
                |> assign(:current_user, session.user)
            else
                conn
                |> assign(:session, nil)
                |> assign(:current_user, nil)
            end
        end
    end
end
