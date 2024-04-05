extends Node2D

func _on_texture_button_pressed():
	Events.attack.emit()
