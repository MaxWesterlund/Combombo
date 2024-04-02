extends Control

var level_panel = preload("res://Scenes/Menus/level_panel.tscn")

func _ready():
	var dir = DirAccess.open("Levels/")
	if dir:
		var format_exp = RegEx.new()
		format_exp.compile("[.]\\w+$")
		
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if format_exp.search(file_name).get_string() == ".png":
				var instance = level_panel.instantiate()
				get_node("ScrollContainer/CenterContainer/GridContainer").add_child(instance)
				instance.level_path = "res://Levels/" + file_name
				instance.display_level()
			file_name = dir.get_next()
