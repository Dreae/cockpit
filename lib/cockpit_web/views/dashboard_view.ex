defmodule CockpitWeb.DashboardView do
    use CockpitWeb, :view

    def gravatar(conn) do
        hash = conn.assigns[:user].email
            |> String.downcase()
            |> :erlang.md5()
            |> Base.encode16(case: :lower)

        "https://www.gravatar.com/avatar/#{hash}?s=150&d=identicon"
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
