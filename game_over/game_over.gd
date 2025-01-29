extends Control

@onready var moves_label = $NinePatchRect/MC/VB/HB/MovesLabel
@onready var in_game_side_menu: VBoxContainer = $"../HB/MC2/VBoxContainer"
@onready var highscore_label: Label = $"NinePatchRect/MC/VB/HB2/Highscore Label"

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_game_over.connect(on_game_over)


func on_game_over(lvl: int, moves: int) -> void:
	in_game_side_menu.visible = false
	moves_label.text = str(moves)
	var high_score = GameManager.get_high_score(lvl)
	if high_score > 0:
		highscore_label.text = "Best: %s" % high_score
		highscore_label.visible = true
	show()

func _on_exit_button_pressed():
	hide()
	SignalManager.on_game_exit_pressed.emit()
