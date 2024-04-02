extends Area2D

func _on_body_entered(body):
	Globals.parts_of_player_in_goal += 1

func _on_body_exited(body):
	Globals.parts_of_player_in_goal -= 1
