extends Node2D

enum STATE {
	IDLE,
	WILL_EXPLODE,
}

var state = STATE.IDLE

@onready var attack_button: Button = get_node("/root/Main/AttackButton")

@onready var timer: Timer = $Timer
@onready var time_text: LineEdit = $LineEdit
@onready var sprite: Sprite2D = $Sprite2D
@onready var explosion_texture: Texture2D = load("res://Sprites/explosion.png")

func _ready():
	time_text.add_to_group("UI")
	attack_button.pressed.connect(start_timer)
	print(explosion_texture)
	pass

func _process(delta):
	if not timer.is_stopped():
		time_text.editable = false
		time_text.text = str(timer.time_left)

func start_timer():
	if not timer.is_stopped():
		return
	state = STATE.WILL_EXPLODE
	print(time_text.text)
	timer.wait_time = float(time_text.text)
	print(timer.wait_time)
	timer.start()

func _on_timer_timeout():
	print("BOOOOOM")
	sprite.texture = explosion_texture
	time_text.visible = false
