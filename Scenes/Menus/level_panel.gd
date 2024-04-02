extends PanelContainer

@export var level_path = ""

var game_scene = preload("res://Scenes/main.tscn")

func display_level():
	get_node("MarginContainer/CenterContainer/GridContainer/Label").text = level_path
	get_node("MarginContainer/CenterContainer/GridContainer/TextureRect").texture = load(level_path)

func _on_button_pressed():
	Globals.map_path = level_path
	get_tree().change_scene_to_packed(game_scene)
