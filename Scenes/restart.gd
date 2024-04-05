extends Node2D

func _ready():
	Events.player_not_won.connect(on_player_not_won)

func on_player_not_won(bombing_time: float):
	visible = true

func _on_texture_button_pressed():
	Events.restart.emit()
