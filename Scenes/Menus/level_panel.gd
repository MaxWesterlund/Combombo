extends PanelContainer

var level_image: Image

var game_scene = preload("res://Scenes/main.tscn")

func display_level(image: Image, name: String):
	level_image = image
	get_node("MarginContainer/CenterContainer/GridContainer/Label").text = name
	get_node("MarginContainer/CenterContainer/GridContainer/TextureRect").texture = ImageTexture.create_from_image(level_image)

func _on_button_pressed():
	Globals.level_image = level_image
	get_tree().change_scene_to_packed(game_scene)
