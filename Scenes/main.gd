extends Node2D

func _on_attack_pressed():
	Events.attack.emit()
