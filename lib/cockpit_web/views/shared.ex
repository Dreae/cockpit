defmodule CockpitWeb.ViewShared do
  def gravatar(user) do
    hash = user.email
      |> String.downcase()
      |> :erlang.md5()
      |> Base.encode16(case: :lower)

    "https://www.gravatar.com/avatar/#{hash}?s=150&d=identicon"
  end
end