extends Window

var set_port = func(): Network.port = int(port_edit.text)
var set_address = func(): Network.address = address_edit.text

func _on_close_requested():
	visible = !visible

func _on_join_pressed():
	Network.create_client()

func _ready():
	set_port.call()
	set_address.call()
	
	port_edit.text_changed.connect( func(value): set_port.call() )
	address_edit.text_changed.connect( func(value): set_address.call() )

@onready var port_edit: LineEdit = get_node("VBoxContainer/LineEdit")
@onready var address_edit: LineEdit = get_node("VBoxContainer/LineEdit2")
