extends Node2D

var bomb = preload("res://Scenes/bombo.tscn")
var bomb_moving: RigidBody2D = null
var bomb_delta: Vector2

var cursor = load("res://Sprites/cursor.png")
var cursor_hold = load("res://Sprites/cursor_hold.png")

func _ready():
	Events.bomb_press.connect(handle_bomb_press)
	Events.attack.connect(on_attack)

func _process(_delta):
	if bomb_moving:
		bomb_moving.position = get_global_mouse_position() + bomb_delta
		if Input.is_action_just_released("pick_bomb"):
			handle_bomb_release()

func spawn_bomb(pos: Vector2):
	var instance = bomb.instantiate()
	instance.position = pos
	add_child(instance)

func handle_bomb_press(bomb_rb: RigidBody2D):
	if bomb_moving == null:
		CursorUpdater.is_holding = true
		bomb_rb.reparent(get_node("/root/Main/MapGenerator"))
		bomb_moving = bomb_rb
		bomb_delta = bomb_rb.position - get_global_mouse_position()
	bomb_moving.freeze = true

func handle_bomb_release():
	CursorUpdater.is_holding = false
	if bomb_moving != null:
		bomb_moving.freeze = false
		bomb_moving = null

func on_attack():
	for b in get_tree().get_nodes_in_group("Bombs"):
		b.reparent(get_node("/root/Main/MapGenerator"))
		if bomb_moving != null:
			bomb_moving.freeze = false
		bomb_moving = null
