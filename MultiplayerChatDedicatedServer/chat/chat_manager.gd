extends CanvasLayer

var server_nickname = "SERVER"

func _on_push_pressed():
	if Network.peer == null or message_edit.text.is_empty(): return
	var nickname = ChatManager.server_nickname if nickname_edit.text.is_empty() else nickname_edit.text
	var message = create_message(nickname, message_edit.text)
	Network.send_packet(PacketManager.create_packet(\
			PacketManager.PacketTypes.send_message_request, message))
	
	add_message(message)

func send_message(message: Dictionary):
	add_message(message)
	Network.send_packet(Network.variant_to_buffer(message))

func add_message(message: Dictionary):
	messages_text_label.append_text("\n" + message["nickname"] + ": " + message["message"])

func create_message(nickname: String, message: String):
	return {"nickname": nickname, "message": message}

@onready var message_edit: LineEdit = get_node("VBoxContainer/HBoxContainer/LineEdit")
@onready var nickname_edit: LineEdit = get_node("VBoxContainer/LineEdit2")
@onready var messages_text_label: RichTextLabel = get_node("VBoxContainer/RichTextLabel")
