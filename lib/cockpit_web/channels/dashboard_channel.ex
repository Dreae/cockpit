defmodule CockpitWeb.DashboardChannel do
  use Phoenix.Channel

  def join("dashboard:pps", _message, socket) do
    case socket.assigns[:user].level do
      :admin ->
        :timer.send_interval(5000, :update)
        {:ok, socket}
      _ ->
        {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info({:current_pps, pps}, socket) do
    push(socket, "pps_update", %{pps: pps})
    {:noreply, socket}
  end

  def handle_info(:update, socket) do
    send(Cockpit.Timeseries.Agent, {:current_pps, self()})
    {:noreply, socket}
  end
end
