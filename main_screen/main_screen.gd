extends Control

@export var level_button_scene: PackedScene
@onready var hb_levels = $VB/HBLevels

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.load_high_score_from_file()
	setup_grid()

func create_level_button(ln: int) -> void:
	var new_lb = level_button_scene.instantiate()
	hb_levels.add_child(new_lb)
	new_lb.set_level_number(ln)

func setup_grid() -> void:
	for level in GameManager.LEVELS:
		create_level_button(level)


func _on_credits_button_pressed() -> void:
	hb_levels.hide()
	SignalManager.on_credits_button_pressed.emit()
