extends Node2D

enum STATE {
	IDLE,
	WILL_EXPLODE,
	EXPLODED,
}

var state = STATE.IDLE

var explode_time = 1.0

@onready var attack_button: Button = get_node("/root/Main/AttackButton")
@onready var player = get_node("/root/Main/Player")

@onready var timer: Timer = $Timer
@onready var time_text: Label = $Label
@onready var sprite: Sprite2D = $Sprite2D
@onready var explosion_texture: Texture2D = load("res://Sprites/explosion.png")

func _ready():
	time_text.add_to_group("UI")
	attack_button.pressed.connect(start_timer)

func _process(delta):
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
	Events.bomb_exploded.emit(position, 1000000)
	sprite.texture = explosion_texture
	time_text.visible = false
	state = STATE.EXPLODED
	$FadeTimer.start()

func _on_fade_timer_timeout():
	queue_free()
