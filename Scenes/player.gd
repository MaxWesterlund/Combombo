extends RigidBody2D

const max_distance_multiplier = 4
var distance_that_will_max_mult = 40

var bombing_started_time: float

var bombs_exploded = 0
var all_bombs_exploded = false
var has_won = false

var elapsed_time = 0.0

func _ready():
	Events.bomb_exploded_at_player.connect(get_exploded_at)
	Events.all_bombs_exploded_and_finished.connect(on_all_bombs_exploded_and_finished)
	Events.attack.connect(on_attack)
	Globals.player_position = position

func _process(delta):
	elapsed_time += delta
	Globals.player_position = position
	if not has_won and all_bombs_exploded and linear_velocity.length() <= 0.1 and Globals.parts_of_player_in_goal > 0:
		linear_velocity = Vector2.ZERO
		has_won = true
		Events.player_won.emit(elapsed_time - bombing_started_time)

func on_attack():
	bombing_started_time = elapsed_time

func on_all_bombs_exploded_and_finished():
	all_bombs_exploded = true

func get_exploded_at(origin: Vector2, size: float):
	add_explode_force(origin, size)

func add_explode_force(origin: Vector2, size: float):
	var d = position - origin
	var direction = d.normalized()
	var distance_multiplier = min(
		max_distance_multiplier * distance_that_will_max_mult / max(d.length(), distance_that_will_max_mult), 
		max_distance_multiplier
	)
	apply_force(direction * size * distance_multiplier)
