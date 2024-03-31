extends Node

@export var image_path = ""

var wall = preload("res://Scenes/Map/Wall.tscn")
var ground = preload("res://Scenes/Map/Floor.tscn")
var spawn = preload("res://Scenes/Map/Spawn.tscn")
var goal = preload("res://Scenes/Map/Goal.tscn")

var bomb = preload("res://Scenes/Bombo.tscn")

func _ready():
	var image = Image.new()
	image.load(image_path)
	
	var height = image.get_height()
	var width = image.get_width()
	var pp: Vector2
	
	for y in range(height - 1):
		for x in range(width):
			var color = image.get_pixel(x, y)
			var tile = tile_from_color(color)
			var instance = tile.instantiate()
			var position = Vector2(x * 64 - width * 32 + 32, y * 64 - height * 32 + 32)
			instance.position = position
			add_child(instance)
			if color == Color(1, 0, 1, 1):
				pp = position
	var bomb_count = 0
	var bombs = []
	for x in range(width):
		var color = image.get_pixel(x, height - 1)
		if color != Color(0, 0, 0, 0):
			bombs.append(color.r + color.g + color.b)
			
	var individual = 40
	var total = individual * bomb_count
	for i in bombs:
		var instance = bomb.instantiate()
		instance.explode_time = i
		instance.position = Vector2(-total/2.0 * individual, 400)
		add_child(instance)
	
	get_node("/root/Main/Player").position = pp

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
