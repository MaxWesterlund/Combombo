extends Node2D

func _on_texture_button_pressed():
	Events.goto_menu.emit()
