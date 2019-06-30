defmodule CockpitWeb.DashboardChannel do
  use Phoenix.Channel

  def join("dashboard:pps", _message, socket) do
    case socket.assigns[:user].level do
      :admin ->
        send(self(), :update)
        :timer.send_interval(20000, :update)
        {:ok, socket}
      _ ->
        {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("pps_summary", _, socket) do
    send(Cockpit.Timeseries.Agent, {:pps_summary, self()})
    {:noreply, socket}
  end

  def handle_info({:current_pps, pps}, socket) do
    push(socket, "pps_update", pps)
    {:noreply, socket}
  end

  def handle_info({:pps_summary, summary}, socket) do
    push(socket, "pps_summary", summary)
    {:noreply, socket}
  end

  def handle_info(:update, socket) do
    send(Cockpit.Timeseries.Agent, {:current_pps, self()})
    {:noreply, socket}
  end
end
