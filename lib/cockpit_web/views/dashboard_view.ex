defmodule CockpitWeb.DashboardView do
    use CockpitWeb, :view
    import CockpitWeb.ViewShared
    import CockpitWeb.Plugs.Authorize

    def nav_block(title, conn, opts, content) do
        needed_level = Keyword.get(opts, :level, :user)
         if conn.assigns[:current_user].level ~> needed_level do
            nav_block(title, content)
        else
            nil
        end
    end

    def nav_block(title, content) do
        [
            content_tag(:li, title, class: "uk-nav-header"),
            content[:do]
        ]
    end

    def nav_link(conn, item, opts, content) do
        needed_level = Keyword.get(opts, :level, :user)
        if conn.assigns[:current_user].level ~> needed_level do
            nav_link(conn, item, content)
        else
            nil
        end
    end

    def nav_link(conn, item, content) do
        class = if conn.assigns[:active_link] == item do
            "uk-active"
        else
            ""
        end

        content_tag :li, content[:do], class: class
    end
  end
