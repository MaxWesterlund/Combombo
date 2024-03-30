extends Node2D

var bomb = preload("res://Scenes/bombo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("place_bomb"):
		var p = get_global_mouse_position()
		if not Utils.is_mouse_over_ui(p):
			spawn_bomb(p)

func spawn_bomb(position: Vector2):
	var instance = bomb.instantiate()
	instance.position = position
	add_child(instance)
