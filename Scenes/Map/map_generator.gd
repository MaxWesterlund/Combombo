extends Node

@export var image_path = ""

var wall = preload("res://Scenes/Map/Wall.tscn")
var ground = preload("res://Scenes/Map/Floor.tscn")
var spawn = preload("res://Scenes/Map/Spawn.tscn")
var goal = preload("res://Scenes/Map/Goal.tscn")

func _ready():
	var image = Image.new()
	image.load(image_path)
	
	var height = image.get_height()
	var width = image.get_width()
	
	for y in range(height):
		for x in range(width):
			var color = image.get_pixel(x, y)
			var tile = tile_from_color(color)
			var instance = tile.instantiate()
			var position = Vector2(x * 64 - width * 32 + 32, y * 64 - height * 32 + 32)
			instance.position = position
			add_child(instance)
	
	Events.spawn_player.emit()

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
