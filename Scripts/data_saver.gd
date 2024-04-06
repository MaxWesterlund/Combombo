extends Node

const file_path = "user://save"

var levels = {
	
}

func _init():
	Events.player_won.connect(on_player_won)

func _ready():
	load_levels_if_exists()

func save_highscore_if_better(score: float):
	var image = Globals.level_image
	if image == null:
		return
	
	var data = str(image.data["data"])
	if not levels.has(data):
		levels[data] = {"highscore": score}
	elif score < levels[data]["highscore"]:
		levels[data]["highscore"] = score
	save()

func get_highscore(image: Image) -> float:
	var data = str(image.data["data"])
	if levels.has(data) and levels[data].has("highscore"):
		return levels[data]["highscore"]
	return -1

func on_player_won(bombing_time: float):
	save_highscore_if_better(bombing_time)

func load_levels_if_exists():
	if not FileAccess.file_exists(file_path):
		FileAccess.open(file_path, FileAccess.WRITE)
		return
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	var file_text = file.get_as_text()
	if file_text.length() == 0:
		return
	
	var json = JSON.new()
	var error = json.parse(file_text)
	if error == OK:
		var json_data = json.data
		levels = json_data

func save():
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(levels))

func store_just_added_custom_level(image: Image, name: String):
	var data = str(image.data["data"])
	levels[data] = {"highscore": -1}
	levels[data]["is_custom"] = true
	levels[data]["name"] = name
	levels[data]["width"] = image.get_width()
	levels[data]["height"] = image.get_height()
	save()

func get_stored_custom_levels():
	var output = []
	#print(levels)
	for l in levels:
		var arr = str_to_var(l)
		if levels[l].has("is_custom") and levels[l]["is_custom"] == true:
			var image = Image.create_from_data(levels[l]["width"], levels[l]["height"], false, Image.FORMAT_RGBA8, arr)
			output.append({"image": image, "name": levels[l]["name"]})
	#print("o")
	#print(output)
	return output
