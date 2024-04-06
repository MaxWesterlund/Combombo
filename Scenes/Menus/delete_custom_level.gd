extends Control

@export var level_panel: Node

func _on_button_pressed():
	DataSaver.delete_custom_level(level_panel.level_image)
	get_tree().reload_current_scene()
