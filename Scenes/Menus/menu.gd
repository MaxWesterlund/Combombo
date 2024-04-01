extends Control

var game_scene = preload("res://Scenes/Menus/level_select.tscn")

func _on_start_pressed():
	get_tree().change_scene_to_packed(game_scene)

func _on_exit_pressed():
	get_tree().quit()
