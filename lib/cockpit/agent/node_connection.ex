defmodule Cockpit.Agent.NodeConnection do
  use GenServer
  use Cockpit.Agent.EncryptedSocket
  require Logger
  
  alias Cockpit.Servers

  def start_link(client) do
    GenServer.start_link(__MODULE__, client)
  end

  def init(client) do
    :inet.setopts(client, [active: :once])
    {:ok, %{server_id: nil, socket: client}}
  end

  def handle_info({:connected, server_id}, state) do
    Phoenix.PubSub.subscribe(Cockpit.PubSub, "CockpitNode:#{server_id}")
    Phoenix.PubSub.subscribe(Cockpit.PubSub, "GameServers:updates")
    Servers.set_status(server_id, :up)

    {:noreply, state}
  end

  def handle_info({:decrypted, "ping"}, state) do
    send_encrypted('pong', state)

    {:noreply, state}
  end

  def handle_info({:decrypted, <<"pps", _pps::big-unsigned-64>>}, state) do
    {:noreply, state}
  end

  # https://gitlab.com/Dreae/compressor/blob/master/src/cockpit_port.h#L40
  # TODO: Figure out a better place to do this
  def handle_info({:server_update, %Cockpit.GameServers.GameServer{} = server_info}, state) do
    {bind_octet_1, bind_octet_2, bind_octet_3, bind_octet_4} = server_info.bind
    {dest_octet_1, dest_octet_2, dest_octet_3, dest_octet_4} = server_info.dest
    {inte_octet_1, inte_octet_2, inte_octet_3, inte_octet_4} = server_info.internal_ip
    bind_addr = <<bind_octet_1, bind_octet_2, bind_octet_3, bind_octet_4>>
    dest_addr = <<dest_octet_1, dest_octet_2, dest_octet_3, dest_octet_4>>
    inte_addr = <<inte_octet_1, inte_octet_2, inte_octet_3, inte_octet_4>>

    packet = <<"server_update">>
      <> bind_addr 
      <> <<server_info.bind_port::big-unsigned-16>>
      <> dest_addr
      <> <<server_info.dest_port::big-unsigned-16>>
      <> inte_addr
      <> <<server_info.cache_time::big-unsigned-32>>
      <> <<server_info.a2s_info_cache::big-unsigned-32>>
    
    send_encrypted(packet, state)

    {:noreply, state}
  end

  def terminate(_reason, %{server_id: server_id}) do
    Servers.set_status(server_id, :down)
  end
end
