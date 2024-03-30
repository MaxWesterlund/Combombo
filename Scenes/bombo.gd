extends Node2D

enum STATE {
	IDLE,
	WILL_EXPLODE,
}

var state = STATE.IDLE

var time_until_explode = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_timer():
	
