extends Node2D

var bomb_scene = preload("res://Scenes/bombo.tscn")

func _ready():
	Events.attack.connect(on_attack)

func on_attack():
	for n in get_children():
		remove_child(n)
		n.queue_free()
	var bombs = get_tree().get_nodes_in_group("Bombs")
	for b in bombs:
		var bomb_ghost = bomb_scene.instantiate()
		bomb_ghost.position = b.position
		bomb_ghost.set_explode_time_start(b.explode_time_start)
		var sprite = bomb_ghost.get_node("Sprite2D")
		sprite.position = sprite.global_position
		sprite.modulate.a = 0.3
		var label = bomb_ghost.get_node("Label")
		label.position = label.global_position
		label.text = "%.1f" % bomb_ghost.explode_time_start
		add_child(sprite.duplicate())
		add_child(label.duplicate())
