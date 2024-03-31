extends Node2D

enum STATE {
	IDLE,
	WILL_EXPLODE,
	EXPLODED,
}

var state = STATE.IDLE

var explode_time = 1.0

var mouse_over = false

@onready var player = get_node("/root/Main/Player")

@onready var timer: Timer = $Timer
@onready var time_text: Label = $Label
@onready var sprite: Sprite2D = $Sprite2D
@onready var explosion_texture: Texture2D = load("res://Sprites/explosion.png")

func _ready():
	add_to_group("Bombs")
	time_text.add_to_group("UI")
	Events.attack.connect(start_timer)
	time_text.text = "%.1f" % explode_time

func _process(delta):
	sprite.flip_v = mouse_over
	if not timer.is_stopped():
		explode_time = timer.time_left
	time_text.text = "%.1f" % explode_time

func start_timer():
	if state != STATE.IDLE:
		return
	state = STATE.WILL_EXPLODE
	if explode_time <= 0.01:
		_on_timer_timeout()
		return
	timer.wait_time = explode_time
	timer.start()

func _on_timer_timeout():
	if can_reach_player():
		Events.bomb_exploded.emit(position, 1000000)
	sprite.texture = explosion_texture
	time_text.visible = false
	state = STATE.EXPLODED
	$FadeTimer.start()

func can_reach_player():
	var pp =  Globals.player_position
	var d = position - pp
	
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	
	var query = PhysicsRayQueryParameters2D.create(position, pp, get_visibility_layer_bit(0))
	var result = space_state.intersect_ray(query)
	
	return !result

func _on_fade_timer_timeout():
	queue_free()

func _on_input_event(viewport, event: InputEvent, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			Events.bomb_press.emit(self)
		elif event.is_released():
			Events.bomb_release.emit(self)
	
	pass # Replace with function body.
