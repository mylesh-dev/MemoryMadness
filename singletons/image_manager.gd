extends Node

const FRAME_IMAGE = preload("res://assets/frames/yellow_frame.png")

var _item_images: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#oad_item_images()
	var ir: ImageFilesList = load("res://image_resources/image_files_list.tres")
	for fn in ir.file_names:
		add_file_to_list_from_resource(fn)

func add_file_to_list_from_resource(fn: String) -> void:
	var ii_dict = {
		"item_name": fn.rstrip(".png"),
		"item_texture": load(fn)
	}
	
	_item_images.append(ii_dict)

func add_file_to_list(fn: String, path: String) -> void:
	var full_path = path + "/" + fn
	
	var ii_dict = {
		"item_name": fn.rstrip(".png"),
		"item_texture": load(full_path)
	}
	
	_item_images.append(ii_dict)

func load_item_images() -> void:
	var path = "res://assets/glitch"
	var dir = DirAccess.open(path)
	
	if not dir:
		print("ERROR: ", path)
		return
	
	var file_names = dir.get_files()
	
	for fn in file_names:
		if ".import" not in fn:
			add_file_to_list(fn, path)
			
	print("loaded:", _item_images.size())


func get_random_item_image() -> Dictionary:
	return _item_images.pick_random()

func get_image(index:int) -> Dictionary:
	return _item_images[index]

func get_frame_image() -> CompressedTexture2D:
	return FRAME_IMAGE

func shuffle_images() -> void:
	_item_images.shuffle()
