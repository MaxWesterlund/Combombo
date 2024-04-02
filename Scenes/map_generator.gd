extends TileMap

var bomb = preload("res://Scenes/bombo.tscn")
var player = preload("res://Scenes/player.tscn")

@onready var camera = get_node("/root/Main/MainCamera")

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
	var image = Globals.level_image
	spawn_tiles_and_player(image)
	spawn_bombs(image)

func spawn_tiles_and_player(image: Image):
	var level_size = Vector2i(image.get_width(), image.get_height() - 1)
	var pp: Vector2
	var has_start = false
	for y in range(level_size.y):
		for x in range(level_size.x):
			var color01 = image.get_pixel(x, y)
			var color = Color8(color01.r8, color01.g8, color01.b8, color01.a8)
			set_cell(0, Vector2i(x, y) - level_size/2, 0, atlas_coords_from_color(color))
			if color == TILE_IMG_COLOR.start:
				has_start = true
				pp = position
	if has_start:
		var player = player.instantiate()
		player.position = pp
		add_child(player)
		Events.spawn_player.emit(pp)

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
	var bombs_values = []
	for x in range(image.get_width()):
		var color = image.get_pixel(x, image.get_height() - 1)
		if color.a8 != 0:
			bombs_values.append(color.r8 + color.g8 + color.b8)
			
	Globals.number_of_bombs = len(bombs_values)
	
	var individual = 40
	var total = individual * len(bombs_values)
	for i in range(len(bombs_values)):
		var instance = bomb.instantiate()
		instance.set_explode_time_start(bombs_values[i] / 10.0)
		instance.position = Vector2(-total/2.0 + individual * i, 200)
		camera.add_child(instance)
