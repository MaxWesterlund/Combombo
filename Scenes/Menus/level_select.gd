extends Control

var level_panel = preload("res://Scenes/Menus/level_panel.tscn")

func _ready():
	add_built_in_levels()

func add_built_in_levels():
	var dir = DirAccess.open("res://Levels/")
	if dir:
		var format_exp = RegEx.new()
		format_exp.compile("[.]\\w+$")
		
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var search = format_exp.search(file_name).get_string()
			if search == ".png":
				add_level("res://Levels/" + file_name)
			elif search == ".import":
				add_level("res://Levels/" + file_name.replace(".import", ""))
			file_name = dir.get_next()

func add_level(path: String):
	var image = load(path)
	if image == null:
		return
	var instance = level_panel.instantiate()
	instance.display_level(image, path)
	get_node("ScrollContainer/CenterContainer/GridContainer").add_child(instance)
