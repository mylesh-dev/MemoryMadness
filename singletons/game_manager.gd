extends Node

const GROUP_TILE: String = "tile"
const SCORES_PATH = "user://highscores.dat"

var _high_scores: Dictionary = {
	#lvlNum: moves
	 "1": 0,
	 "2": 0,
	 "3": 0,
	 "4": 0,
	 "5": 0,
	 "6": 0
}

const LEVELS: Dictionary = {
	1: { "rows": 2, "cols": 2 },
	2: { "rows": 3, "cols": 4 },
	3: { "rows": 4, "cols": 4 },
	4: { "rows": 4, "cols": 6 },
	5: { "rows": 5, "cols": 6 },
	6: { "rows": 6, "cols": 6 }
}


func get_level_selection(level_num: int) -> Dictionary:
	var l_data =  GameManager.LEVELS[level_num]
	var num_tiles = l_data.rows * l_data.cols
	var target_pairs: int = num_tiles / 2 
	var selected_level_images = []
	
	ImageManager.shuffle_images()
	
	for i in range(target_pairs):
		selected_level_images.append(ImageManager.get_image(i))
		selected_level_images.append(ImageManager.get_image(i))
	
	selected_level_images.shuffle()
	
	return {
		"target_pairs": target_pairs,
		"num_cols": l_data.cols,
		"image_list": selected_level_images
	}

func clear_nodes_of_group(g_name:String) -> void:
	for n in get_tree().get_nodes_in_group(g_name):
		n.queue_free()

func get_high_score(lvl: int) -> int:
	return _high_scores[str(lvl)]

func set_high_score(lvl: int, moves: int) -> void:
	_high_scores[str(lvl)] = moves

func save_high_score_to_file() -> void:
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(_high_scores))
		file.close()
	else:
		print("Failed to load file")


func load_high_score_from_file() -> void:
	var file: FileAccess = FileAccess.open(SCORES_PATH, FileAccess.READ)
	if file:
		var text: String = file.get_as_text()
		if text and text.length() > 0:
			_high_scores = JSON.parse_string(file.get_as_text())
		else:
			print("File empty")
		file.close()
	else:
		print("Failed to load file")
