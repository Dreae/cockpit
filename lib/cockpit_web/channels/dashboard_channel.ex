defmodule CockpitWeb.DashboardChannel do
  use Phoenix.Channel

  def join("dashboard:pps", _message, socket) do
    case socket.assigns[:user].level do
      :admin ->
        :timer.send_interval(2000, :update)
        {:ok, socket}
      _ ->
        {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:update, socket) do
    push socket, "pps_update", %{pps: Enum.random(1000..2000)}
    {:noreply, socket}
  end
end
