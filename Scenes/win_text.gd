extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.player_won.connect(on_won)


func on_won(time: float):
	text += "\ntime: %.2f" % time
	visible = true
