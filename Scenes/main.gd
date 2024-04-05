extends Node2D

var menu_scene: PackedScene
var game_scene = preload("res://Scenes/main.tscn")

func _ready():
	menu_scene = load("res://Scenes/Menus/menu.tscn")
	Events.goto_menu.connect(on_goto_menu)
	Events.restart.connect(on_restart)

func on_goto_menu():
	get_tree().change_scene_to_packed(menu_scene)

func on_restart():
	get_tree().change_scene_to_packed(game_scene)	
