extends PanelContainer

var level_image: Image

var game_scene = preload("res://Scenes/main.tscn")

@export var delete_button: Control

func display_level(image: Image, level_name: String):
	level_image = image
	get_node("MarginContainer/CenterContainer/GridContainer/Label").text = level_name
	get_node("MarginContainer/CenterContainer/GridContainer/TextureRect").texture = ImageTexture.create_from_image(level_image)
	var highscore = DataSaver.get_highscore(image)
	var highscore_text = "Highscore: %.2f" % highscore + " s"
	if highscore < 0:
		highscore_text = ""
	get_node("MarginContainer/CenterContainer/GridContainer/HighscoreLabel").text = highscore_text
	
func _on_button_pressed():
	Globals.level_image = level_image
	get_tree().change_scene_to_packed(game_scene)

func set_is_custom(is_custom: bool):
	delete_button.visible = is_custom
