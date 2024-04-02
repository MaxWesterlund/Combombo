extends Node

var cursor = load("res://Sprites/cursor.png")
var cursor_click = load("res://Sprites/cursor_click.png")
var cursor_hold = load("res://Sprites/cursor_hold.png")

var last_click_time = 0

var last_is_holding = false
var is_holding = false

func _process(_delta):
	if Input.is_action_just_pressed("pick_bomb"):
		Input.set_custom_mouse_cursor(cursor_click)
		last_click_time = Time.get_ticks_msec()
	
	if is_holding && !last_is_holding:
		Input.set_custom_mouse_cursor(cursor_hold)
	elif Time.get_ticks_msec() > last_click_time + 100 && !is_holding:
		Input.set_custom_mouse_cursor(cursor)
	
	last_is_holding = is_holding
