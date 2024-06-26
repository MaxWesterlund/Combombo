extends Node

signal attack
signal bomb_exploded(position: Vector2, force: float, node: Node2D)
signal bomb_exploded_finished_animation(node: Node2D)
signal bomb_exploded_at_player(position: Vector2, force: float)
signal spawn_player(position: Vector2)
signal bomb_press(bomb: RigidBody2D)
signal all_bombs_exploded_and_finished
signal player_entered_goal
signal player_won(bombing_time: float)
signal player_not_won(bombing_time: float)
signal restart
signal goto_menu
