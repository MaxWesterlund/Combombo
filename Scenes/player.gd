extends RigidBody2D

@export var ground_friction = 0.0

const max_distance_multiplier = 4

func _ready():
	linear_damp = ground_friction
	Events.bomb_exploded.connect(add_explode_force)

func _process(delta):
	pass
	#if Input.is_action_just_pressed("place_bomb"):
		#var p = get_global_mouse_position()
		#if not is_mouse_over_ui(p):
			#add_explode_force(1000000, p)

func add_explode_force(origin: Vector2, size: float):
	var d = position - origin
	var direction = d.normalized()
	var distance_multiplier = min(100 / d.length(), max_distance_multiplier)
	apply_force(direction * size * distance_multiplier)
