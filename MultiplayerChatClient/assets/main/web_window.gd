extends Window

func _on_close_requested():
	visible = !visible

func _on_join_pressed():
	Network.create_client()
