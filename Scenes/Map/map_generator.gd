extends Node

@export var image_path = ""

var wall = preload("res://Scenes/Map/Wall.tscn")
var ground = preload("res://Scenes/Map/Floor.tscn")
var spawn = preload("res://Scenes/Map/Spawn.tscn")
var goal = preload("res://Scenes/Map/Goal.tscn")

func _ready():
	var image = Image.new()
	image.load(image_path)
	
	for y in range(image.get_height()):
		for x in range(image.get_width()):
			var color = image.get_pixel(x, y)
			var tile = tile_from_color(color)
			var instance = tile.instantiate()
			var position = Vector2(x * 64, y * 64)
			instance.position = position
			add_child(instance)

func tile_from_color(color) -> PackedScene:
	match color:
		Color(1, 0, 0, 1):
			return wall
		Color(0, 1, 0, 1):
			return ground
		Color(1, 0, 1, 1):
			return spawn
		Color(1, 1, 0, 1):
			return goal
	return ground
