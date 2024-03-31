extends RigidBody2D

const max_distance_multiplier = 4

func _ready():
	Events.bomb_exploded.connect(add_explode_force)
	Globals.player_position = position

func _process(delta):
	Globals.player_position = position

func add_explode_force(origin: Vector2, size: float):
	var d = position - origin
	var direction = d.normalized()
	var distance_multiplier = min(100 / d.length(), max_distance_multiplier)
	apply_force(direction * size * distance_multiplier)
