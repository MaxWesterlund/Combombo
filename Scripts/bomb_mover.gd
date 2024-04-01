extends Node2D

var bomb = preload("res://Scenes/bombo.tscn")
var bomb_moving: RigidBody2D = null
var bomb_delta: Vector2

func _ready():
	Events.bomb_press.connect(handle_bomb_press)

func _process(delta):
	if bomb_moving:
		bomb_moving.position = get_global_mouse_position() + bomb_delta
		if Input.is_action_just_released("pick_bomb"):
			handle_bomb_release()

func spawn_bomb(position: Vector2):
	var instance = bomb.instantiate()
	instance.position = position
	add_child(instance)

func handle_bomb_press(bomb: RigidBody2D):
	if bomb_moving == null:
		bomb_moving = bomb
		bomb_delta = bomb.position - get_global_mouse_position()
	bomb_moving.freeze = true

func handle_bomb_release():
	if bomb_moving != null:
		bomb_moving.freeze = false
		bomb_moving = null
