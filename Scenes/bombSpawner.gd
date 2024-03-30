extends Node2D

var bomb = preload("res://Scenes/bombo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("place_bomb"):
		var p = get_global_mouse_position()
		if not is_mouse_over_ui(p):
			spawn_bomb(p)

func spawn_bomb(position: Vector2):
	var instance = bomb.instantiate()
	instance.position = position
	add_child(instance)

func is_mouse_over_ui(mouse_position):
	var ui_elements = get_tree().get_nodes_in_group("UI")

	for ui_element in ui_elements:
		if ui_element.get_global_rect().has_point(mouse_position):
			return true
