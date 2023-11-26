extends Node

var peer: WebSocketMultiplayerPeer
var port: int
var address: String

func create_client():
	peer = WebSocketMultiplayerPeer.new()
	var ok = peer.create_client(address + ":" + str(port))
	print("client created succefful" if ok == OK else "client created failed")
	_bind_peer_signals()

func send_packet(buffer: PackedByteArray, to_peer: int = 0):
	if to_peer:
		peer.set_target_peer(to_peer)
	peer.put_packet(buffer)

func variant_to_buffer(data: Variant):
	var json_data = JSON.stringify(data)
	var buffer = json_data.to_utf8_buffer()
	return buffer

func _process(delta):
	if peer == null:
		return
		
	peer.poll()

func _bind_peer_signals():
	peer.peer_connected.connect(_peer_connected)
	peer.peer_disconnected.connect(_peer_disconnected)

func _peer_connected(peer):
	var message = ChatManager.create_message(ChatManager.server_nickname, "connect to " + str(peer))
	ChatManager.add_message(message)

func _peer_disconnected(peer):
	var message = ChatManager.create_message(ChatManager.server_nickname, "disconnect from " + str(peer))
	ChatManager.add_message(message)
