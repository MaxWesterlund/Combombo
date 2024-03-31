extends Camera2D

@export var move_speed = 0.0
@export var zoom_speed = 0.0
@export var max_zoom = 1.0
@export var min_zoom = 1.0

func _process(delta):
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
	
	position += move_speed * delta * dir
	
	var zoom_dir = 0
	
	if Input.is_action_just_pressed("zoom_in"):
		zoom_dir += 1
	if Input.is_action_just_pressed("zoom_out"):
		zoom_dir -= 1
	
	var zoom_amount = clampf(zoom.x + zoom_dir * zoom_speed, min_zoom, max_zoom)
	
	zoom = Vector2(zoom_amount, zoom_amount)
