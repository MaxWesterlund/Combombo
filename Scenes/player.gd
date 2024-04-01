extends RigidBody2D

const max_distance_multiplier = 4
var distance_that_will_max_mult = 40

func _ready():
	Events.bomb_exploded.connect(add_explode_force)
	Globals.player_position = position

func _process(delta):
	Globals.player_position = position

func add_explode_force(origin: Vector2, size: float):
	var d = position - origin
	var direction = d.normalized()
	var distance_multiplier = min(
		max_distance_multiplier * distance_that_will_max_mult / max(d.length(), distance_that_will_max_mult), 
		max_distance_multiplier
	)
	apply_force(direction * size * distance_multiplier)
