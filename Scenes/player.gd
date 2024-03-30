extends RigidBody2D

@export var ground_friction = 0.0

const max_distance_multiplier = 4

func _ready():
	linear_damp = ground_friction
	
func _process(delta):
	if Input.is_action_just_pressed("place_bomb"):
		var p = get_global_mouse_position()
		if not is_mouse_over_ui(p):
			add_explode_force(1000000, p)

func add_explode_force(size, origin):
	var d = position - origin
	var direction = d.normalized()
	var distance_multiplier = min(100 / d.length(), max_distance_multiplier)
	apply_force(direction * size * distance_multiplier)

func is_mouse_over_ui(mouse_position):
	var ui_elements = get_tree().get_nodes_in_group("UI")

	for ui_element in ui_elements:
		if ui_element.get_global_rect().has_point(mouse_position):
			return true
