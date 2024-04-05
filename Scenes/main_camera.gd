extends Camera2D

@export var move_speed = 0.0
@export var zoom_speed = 0.0
@export var max_zoom = 1.0
@export var min_zoom = 1.0

var is_attacking: bool = false

var last_player_position = null

func _init():
	Events.spawn_player.connect(on_spawn_player)
	Events.attack.connect(on_attack)

func on_spawn_player(pos: Vector2):
	position = pos

func on_attack():
	is_attacking = true

func _process(delta):
	if !is_attacking:
		move(delta)
	else:
		follow_player()

func move(delta):
	var dir = Vector2(0, 0)
	if Input.is_action_pressed("move_up"):
		dir.y -= 1
	if Input.is_action_pressed("move_down"):
		dir.y += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	
	dir = dir.normalized()
	
	var zoom_dir = 0
	
	if Input.is_action_just_pressed("zoom_in"):
		zoom_dir += 1
	if Input.is_action_just_pressed("zoom_out"):
		zoom_dir -= 1
	
	var zoom_amount = clampf(zoom.x + zoom_dir * zoom_speed, min_zoom, max_zoom)
	
	position += move_speed * (1.0 / zoom_amount) * delta * dir
	zoom = Vector2(zoom_amount, zoom_amount)

func follow_player():
	if last_player_position != null:
		position = last_player_position
	zoom = Vector2(1, 1)
	last_player_position = Globals.player_position
