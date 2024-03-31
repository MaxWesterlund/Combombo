extends Button

func _on_pressed():
	Events.attack.emit()
