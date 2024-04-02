extends Control

var level_panel = preload("res://Scenes/Menus/level_panel.tscn")

var format_exp = RegEx.new()
var name_exp = RegEx.new()

func _ready():
	format_exp.compile("[.]\\w+$")
	name_exp.compile("^\\w+")
	add_built_in_levels()

func on_add_custom_levels():
	var line_edit = get_node("CenterContainer/TextureRect/LineEdit")
	line_edit.get_parent().visible = true
	line_edit.editable = true

func on_custom_folder_selected(path: String):
	var line_edit = get_node("CenterContainer/TextureRect/LineEdit")
	line_edit.get_parent().visible = false
	line_edit.editable = false
	line_edit.text = ""
	add_custom_levels(path + "/")

func add_custom_levels(path: String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var search = format_exp.search(file_name)
			if search == null:
				return
			if search.get_string() == ".png":
				add_level(path + file_name, name_exp.search(file_name).get_string(), false)
			file_name = dir.get_next()

func add_built_in_levels():
	var dir = DirAccess.open("res://Levels/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var search = format_exp.search(file_name).get_string()
			if OS.has_feature("editor"):
				if search == ".png":
					add_level("res://Levels/" + file_name, name_exp.search(file_name).get_string(), true)
			elif search == ".import":
				add_level("res://Levels/" + file_name.replace(".import", ""), name_exp.search(file_name).get_string(), true)
			file_name = dir.get_next()

func add_level(path: String, name: String, builtin: bool):
	var image = load(path) if builtin else Image.load_from_file(path)
	if image == null:
		return
	var instance = level_panel.instantiate()
	instance.display_level(image, name)
	if builtin:
		get_node("ScrollContainer/CenterContainer/VBoxContainer/GridContainerBuiltin").add_child(instance)
	else:
		get_node("ScrollContainer/CenterContainer/VBoxContainer/GridContainerCustom").add_child(instance)
