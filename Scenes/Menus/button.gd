extends MarginContainer

signal pressed

var finished = true

func _on_press():
	$AudioStreamPlayer.play()
	finished = false
	
func _process(_delta):
	if !$AudioStreamPlayer.playing && !finished:
		finished = true
		pressed.emit()
