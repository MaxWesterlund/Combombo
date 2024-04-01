extends RigidBody2D

enum STATE {
	IDLE,
	WILL_EXPLODE,
	EXPLODED,
}

var explode_force = 2000000

var state = STATE.IDLE
var explode_time_start = 1.0
var explode_time = explode_time_start

@onready var player = get_node("/root/Main/Player")

@onready var timer: Timer = $Timer
@onready var time_text: Label = $Label
@onready var sprite: Sprite2D = $Sprite2D
@onready var explosion: AnimatedSprite2D = $AnimatedSprite2D

func set_explode_time_start(time: float):
	explode_time_start = time
	explode_time = explode_time_start

func _ready():
	add_to_group("Bombs")
	time_text.add_to_group("UI")
	Events.attack.connect(start_timer)
	time_text.text = "%.1f" % explode_time
	explosion.animation_finished.connect(hide_self)

func _process(delta):
	if not timer.is_stopped():
		explode_time = timer.time_left
	time_text.text = "%.1f" % explode_time
	#print(get_colliding_bodies())

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
	Events.bomb_exploded.emit(position, explode_force, self)
	if can_reach_player():
		Events.bomb_exploded_at_player.emit(position, explode_force)
	time_text.visible = false
	state = STATE.EXPLODED
	sprite.visible = false
	explosion.visible = true
	explosion.play("boom")

func can_reach_player():
	var pp =  Globals.player_position
	var d = position - pp
	
	var space_state = get_world_2d().direct_space_state
	
	var query = PhysicsRayQueryParameters2D.create(position, pp, collision_mask)
	var result = space_state.intersect_ray(query)
	
	return !result

func hide_self():
	visible = false

func _on_input_event(viewport, event: InputEvent, shape_idx):
	if event.is_action_pressed("pick_bomb"):
		if !Utils.is_mouse_over_ui(get_global_mouse_position()):
			Events.bomb_press.emit(self)
