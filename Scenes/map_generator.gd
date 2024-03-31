extends TileMap

@export var image_path = ""

var wall = preload("res://Scenes/Tiles/Wall.tscn")
var ground = preload("res://Scenes/Tiles/Floor.tscn")
var spawn = preload("res://Scenes/Tiles/Spawn.tscn")
var goal = preload("res://Scenes/Tiles/Goal.tscn")

var bomb = preload("res://Scenes/Bombo.tscn")

const TILE_COLOR = {
	ground = Color(0, 1, 0, 1),
	wall = Color(1, 0, 0, 1),
	goal = Color(1, 1, 0, 1)
}

func _ready():
	var image = Image.new()
	image.load(image_path)
	
	var image_height = image.get_height()
	var image_width = image.get_width()
	
	var level_size = Vector2i(image_width, image_height - 1)
	var pp: Vector2
	
	for y in range(level_size.y):
		for x in range(level_size.x):
			var color = image.get_pixel(x, y)
			set_cell(0, Vector2i(x, y) - level_size/2, 0, atlas_coords_from_color(color))
			if color == Color(1, 0, 1, 1):
				pp = position
	var bomb_count = 0
	var bombs = []
	for x in range(image_width):
		var color = image.get_pixel(x, image_height - 1)
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

func atlas_coords_from_color(color) -> Vector2i:
	match color:
		Color(1, 0, 0, 1): # wall
			return Vector2i(2, 0)
		Color(0, 1, 0, 1): # ground
			return Vector2i(0, 0)
		Color(1, 0, 1, 1): # spawn
			return Vector2i(0, 0)
		Color(1, 1, 0, 1): # goal
			return Vector2i(1, 0)
	return ground
