extends RigidBody2D

@export var ground_friction = 0.0

func _ready():
	linear_damp = ground_friction
	
func _process(delta):
	if Input.is_action_just_pressed("place_bomb"):
		add_force(1000000, get_global_mouse_position())
		
func add_force(size, origin):
	var direction = (position - origin).normalized()
	apply_force(Vector2(direction * size))
