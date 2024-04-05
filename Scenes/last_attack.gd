extends Node2D

var bomb_scene = preload("res://Scenes/bombo.tscn")

const alpha = 0.6

var bombs_exploded: Array[Node2D] = []
var bomb_ghosts: Array[Node2D] = []

func _init():
	Events.bomb_exploded_finished_animation.connect(on_bomb_exploded_finished_animation)
	Events.restart.connect(on_restart)

func on_restart():
	Globals.last_attack_bomb_ghosts = bomb_ghosts.duplicate()

func _ready():
	modulate.a = alpha
	if len(Globals.last_attack_bomb_ghosts) > 0:
		for b in Globals.last_attack_bomb_ghosts:
			add_child(b)

func on_bomb_exploded_finished_animation(node: Node2D):
	bombs_exploded.append(node)
	if len(bombs_exploded) >= Globals.number_of_bombs:
		update_ghosts()
		Events.all_bombs_exploded_and_finished.emit()

func update_bombs(bombs: Array[Node2D]):
	bombs_exploded = bombs
	update_ghosts()

func remove_children():
	for n in get_children():
		remove_child(n)
		n.queue_free()

func update_ghosts():
	remove_children()
	
	for b in bombs_exploded:
		var bomb_ghost_temp = bomb_scene.instantiate()
		bomb_ghost_temp.set_explode_time_start(b.explode_time_start)
		var sprite = bomb_ghost_temp.get_node("Sprite2D")
		var label = bomb_ghost_temp.get_node("Label")
		label.text = "%.1f" % bomb_ghost_temp.explode_time_start
		
		var bomb_ghost = Node2D.new()
		bomb_ghost.global_position = b.global_position
		bomb_ghost.add_child(sprite.duplicate())
		bomb_ghost.add_child(label.duplicate())
		add_child(bomb_ghost)
		bomb_ghosts.append(bomb_ghost.duplicate())
		b.queue_free()
