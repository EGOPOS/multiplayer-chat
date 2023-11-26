extends Node

enum PacketTypes{
	send_message_request,
}

func _process(delta):
	if Network.peer == null:
		return
		
	while Network.peer.get_available_packet_count():
		var packet_peer = Network.peer.get_packet_peer()
		var packet = Network.peer.get_packet()
		var data = JSON.parse_string(packet.get_string_from_utf8())
		
		match int(data["type"]):
			PacketTypes.send_message_request:
				var other_peers = Network.peers_connected
#				other_peers.erase(packet_peer)
				print(Network.peers_connected)
				for peer in other_peers:
					Network.send_packet(packet, peer)
				
				ChatManager.add_message(data["value"])

func create_packet(packet_type: PacketTypes, value: Variant):
	var data: Dictionary
	data["type"] = packet_type
	data["value"] = value
	return Network.variant_to_buffer(data)
