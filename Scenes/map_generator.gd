extends TileMap

@export var image_path = ""

var wall = preload("res://Scenes/Tiles/Wall.tscn")
var ground = preload("res://Scenes/Tiles/Floor.tscn")
var spawn = preload("res://Scenes/Tiles/Spawn.tscn")
var goal = preload("res://Scenes/Tiles/Goal.tscn")

var bomb = preload("res://Scenes/Bombo.tscn")

const TILE_IMG_COLOR = {
	ground = Color8(0, 255, 0),
	start = Color8(255, 0, 255),
	goal = Color8(255, 255, 0),
	wall = Color8(255, 0, 0),
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
			var color01 = image.get_pixel(x, y)
			var color = Color8(color01.r8, color01.g8, color01.b8, color01.a8)
			set_cell(0, Vector2i(x, y) - level_size/2, 0, atlas_coords_from_color(color))
			if color == TILE_IMG_COLOR.start:
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
		TILE_IMG_COLOR.ground:
			return Vector2i(0, 0)
		TILE_IMG_COLOR.start:
			return Vector2i(0, 0)
		TILE_IMG_COLOR.goal:
			return Vector2i(1, 0)
		TILE_IMG_COLOR.wall:
			return Vector2i(2, 0)
	return ground
