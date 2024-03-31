extends Node2D

var bomb = preload("res://Scenes/Bombo.tscn")

var bomb_moving: Node2D = null

func _ready():
	Events.bomb_press.connect(handle_bomb_press)
	Events.bomb_release.connect(handle_bomb_release)
	pass

func _process(delta):
	if bomb_moving:
		bomb_moving.position = get_global_mouse_position()
	pass

func spawn_bomb(position: Vector2):
	var instance = bomb.instantiate()
	instance.position = position
	add_child(instance)

func handle_bomb_press(bomb: Node2D):
	if bomb_moving == null:
		bomb_moving = bomb

func handle_bomb_release(bomb: Node2D):
	bomb_moving = null
