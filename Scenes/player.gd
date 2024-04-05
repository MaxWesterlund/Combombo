extends RigidBody2D

@export var min_velocity_sound: float
@export var max_velocity_sound: float

const max_distance_multiplier = 4
var distance_that_will_max_mult = 40

const time_until_lost = 2.0

var bombing_started_time: float

var bombs_exploded = 0
var all_bombs_exploded = false
var game_over_or_won = false

var elapsed_time = 0.0

var all_bombs_exploded_time_start = 0.0

func _ready():
	Events.bomb_exploded_at_player.connect(get_exploded_at)
	Events.all_bombs_exploded_and_finished.connect(on_all_bombs_exploded_and_finished)
	Events.attack.connect(on_attack)
	Globals.player_position = position

func _process(delta):
	elapsed_time += delta
	Globals.player_position = position
	
	if not game_over_or_won:
		if all_bombs_exploded:
			var still: bool = linear_velocity.length() <= 0.1 and abs(angular_velocity) <= 0.01
			if still:
				linear_velocity = Vector2.ZERO
				angular_velocity = 0
				game_over_or_won = true
				if Globals.parts_of_player_in_goal > 0:
					Events.player_won.emit(elapsed_time - bombing_started_time)
				else:
					Events.player_not_won.emit(elapsed_time - bombing_started_time)
			else:
				if elapsed_time - all_bombs_exploded_time_start > time_until_lost:
					game_over_or_won = true
					Events.player_not_won.emit(elapsed_time - bombing_started_time)

func _on_body_entered(_body):
	if $AudioStreamPlayer.playing:
		return
	var vel = linear_velocity.length()
	var amount = clampf((vel - min_velocity_sound) / max_velocity_sound, 0, 1)
	if amount > 0:
		$AudioStreamPlayer.volume_db = 1 - amount
		$AudioStreamPlayer.play()

func on_attack():
	bombing_started_time = elapsed_time

func on_all_bombs_exploded_and_finished():
	all_bombs_exploded_time_start = elapsed_time
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
