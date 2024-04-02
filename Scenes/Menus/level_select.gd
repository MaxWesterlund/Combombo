extends Control

var level_panel = preload("res://Scenes/Menus/level_panel.tscn")

func _ready():
	add_built_in_levels()

func on_add_custom_levels():
	var line_edit = get_node("CenterContainer/LineEdit")
	line_edit.visible = true
	line_edit.editable = true

func on_custom_folder_selected(path: String):
	var line_edit = get_node("CenterContainer/LineEdit")
	line_edit.visible = false
	line_edit.editable = false
	line_edit.text = ""
	add_custom_levels(path + "/")

func add_custom_levels(path: String):
	var dir = DirAccess.open(path)
	if dir:
		var format_exp = RegEx.new()
		format_exp.compile("[.]\\w+$")
		
		var name_exp = RegEx.new()
		name_exp.compile("^\\w+")
		
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var search = format_exp.search(file_name).get_string()
			if search == ".png":
				add_level(path + file_name, name_exp.search(file_name).get_string())
			file_name = dir.get_next()

func add_built_in_levels():
	var dir = DirAccess.open("res://Levels/")
	if dir:
		var format_exp = RegEx.new()
		format_exp.compile("[.]\\w+$")
		
		var name_exp = RegEx.new()
		name_exp.compile("^\\w+")
		
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var search = format_exp.search(file_name).get_string()
			if OS.has_feature("editor"):
				if search == ".png":
					add_level("res://Levels/" + file_name, name_exp.search(file_name).get_string())
			elif search == ".import":
				add_level("res://Levels/" + file_name.replace(".import", ""), name_exp.search(file_name).get_string())
			file_name = dir.get_next()

func add_level(path: String, name: String):
	var image = Image.new()
	image.load(path)
	if image == null:
		return
	var instance = level_panel.instantiate()
	instance.display_level(image, name)
	get_node("ScrollContainer/CenterContainer/GridContainer").add_child(instance)
