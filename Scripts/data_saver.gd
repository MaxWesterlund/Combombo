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
	print(levels.has(data))
	if not levels.has(data):
		levels[data] = score
	elif score < levels[data]:
		levels[data] = score
	save()

func get_highscore(image: Image) -> float:
	var data = str(image.data["data"])
	#print(data)
	if levels.has(data):
		print("hej")
		return levels[data]
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
		print("levels:")
		print(levels)
		print("-------------------------")

func save():
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(levels))
