extends Control
@onready var hb_levels: HBoxContainer = $"../VB/HBLevels"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass
	SignalManager.on_credits_button_pressed.connect(on_credits_show)

func on_credits_show() -> void:
	show()

func _on_exit_button_pressed():
	hide()
	hb_levels.show()
