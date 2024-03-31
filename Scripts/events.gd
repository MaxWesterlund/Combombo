extends Node

signal attack
signal bomb_exploded(position: Vector2, force: float)
signal spawn_player(position: Vector2)
signal bomb_press(bomb: RigidBody2D)
signal bomb_release(bomb: RigidBody2D)
