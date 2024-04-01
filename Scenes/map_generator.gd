extends TileMap

@export var image_path = ""

var bomb = preload("res://Scenes/bombo.tscn")

const TILE_IMG_COLOR = {
	ground = Color8(0, 255, 0),
	start = Color8(255, 0, 255),
	goal = Color8(255, 255, 0),
	wall = Color8(255, 0, 0),
}

const TILE_ATLAS_COORDS = {
	ground = Vector2i(0, 0),
	start = Vector2i(0, 0),
	goal = Vector2i(1, 0),
	wall = Vector2i(2, 0),
}

func _ready():
	var image = Image.new()
	image.load(image_path)

	var start_position = spawn_tiles(image)
	get_node("/root/Main/Player").position = start_position
	
	spawn_bombs(image)

func spawn_tiles(image: Image) -> Vector2:
	var level_size = Vector2i(image.get_width(), image.get_height() - 1)
	var pp: Vector2
	for y in range(level_size.y):
		for x in range(level_size.x):
			var color01 = image.get_pixel(x, y)
			var color = Color8(color01.r8, color01.g8, color01.b8, color01.a8)
			set_cell(0, Vector2i(x, y) - level_size/2, 0, atlas_coords_from_color(color))
			if color == TILE_IMG_COLOR.start:
				pp = position
	return pp

func atlas_coords_from_color(color: Color) -> Vector2i:
	if color.is_equal_approx(TILE_IMG_COLOR.ground):
		return TILE_ATLAS_COORDS.ground
	if color.is_equal_approx(TILE_IMG_COLOR.start):
		return TILE_ATLAS_COORDS.start
	if color.is_equal_approx(TILE_IMG_COLOR.goal):
		return TILE_ATLAS_COORDS.goal
	if color.is_equal_approx(TILE_IMG_COLOR.wall):
		return TILE_ATLAS_COORDS.wall
	return TILE_ATLAS_COORDS.ground

func spawn_bombs(image: Image):
	var bomb_count = 0
	var bombs_values = []
	for x in range(image.get_width()):
		var color = image.get_pixel(x, image.get_height() - 1)
		if color.a8 != 0:
			bombs_values.append(color.r8 + color.g8 + color.b8)
	
	var individual = 40
	var total = individual * bomb_count
	for i in range(len(bombs_values)):
		var instance = bomb.instantiate()
		instance.set_explode_time_start(bombs_values[i] / 10.0)
		instance.position = Vector2(-total/2.0 + individual * i, 400)
		add_child(instance)
