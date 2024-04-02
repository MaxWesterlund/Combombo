extends Area2D

func _on_body_entered(_body):
	Globals.parts_of_player_in_goal += 1

func _on_body_exited(_body):
	Globals.parts_of_player_in_goal -= 1
