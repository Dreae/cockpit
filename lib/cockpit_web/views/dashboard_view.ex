defmodule CockpitWeb.DashboardView do
    use CockpitWeb, :view
    import CockpitWeb.ViewShared

    def nav_link(conn, item, content) do
        class = if conn.assigns[:active_link] == item do
            "uk-active"
        else
            ""
        end

        content_tag :li, content[:do], class: class
    end
  end
