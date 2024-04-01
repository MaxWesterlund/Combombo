extends Node2D

var bomb_scene = preload("res://Scenes/bombo.tscn")

const alpha = 0.6

var bombs_exploded = []

func _ready():
	Events.bomb_exploded.connect(on_bomb_exploded)

func on_bomb_exploded(position: Vector2, force: float, node: Node2D):
	bombs_exploded.append(node)
	if len(bombs_exploded) >= Globals.number_of_bombs:
		update_ghosts()
		Events.all_bombs_exploded.emit()

func update_ghosts():
	for n in get_children():
		remove_child(n)
		n.queue_free()

	for b in bombs_exploded:
		var bomb_ghost = bomb_scene.instantiate()
		bomb_ghost.position = b.position
		bomb_ghost.set_explode_time_start(b.explode_time_start)
		var sprite = bomb_ghost.get_node("Sprite2D")
		sprite.position = sprite.global_position
		sprite.modulate.a = alpha
		var label = bomb_ghost.get_node("Label")
		label.position = label.global_position
		label.text = "%.1f" % bomb_ghost.explode_time_start
		label.modulate.a = alpha
		add_child(sprite.duplicate())
		add_child(label.duplicate())
		b.queue_free()
		
	bombs_exploded.clear()
