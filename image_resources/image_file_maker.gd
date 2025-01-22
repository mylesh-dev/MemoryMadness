#@tool
extends Node

#@export var ir: ImageFilesList

const PATH = "res://assets/glitch"

# Called when the node enters the scene tree for the first time.
func _ready():
	#if Engine.is_editor_hint() == true:
	var dir = DirAccess.open(PATH)
	var ifl: ImageFilesList = ImageFilesList.new()
	
	if not dir:
		print("ERROR: ", PATH)
		return
	
	ifl.file_names.clear()
	
	
	if dir:
		var files: PackedStringArray = dir.get_files()
		
		for fn in files:
			if ".import" not in fn:
				print(fn)
				ifl.add_filename(PATH + "/" + fn)
			
		ResourceSaver.save(ifl, "res://image_resources/image_files_list.tres")
