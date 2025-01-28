extends TextureButton

@onready var label = $Label
@onready var sound = $Sound
@onready var highscore_label: Label = $"Highscore Label"

var _level_number: int =  0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_update_highscore.connect(on_update_highscore)

func set_level_number(level_num: int) -> void:
	_level_number = level_num
	var l_data =  GameManager.LEVELS[_level_number]
	label.text = "%sx%s" % [l_data.rows, l_data.cols]
	
	update_high_score_value()


func _on_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.on_level_selected.emit(_level_number)

func update_high_score_value() -> void:
	var high_score = GameManager.get_high_score(_level_number)
	if high_score > 0:
		highscore_label.text = "Best: %s" % high_score
		highscore_label.visible = true

func on_update_highscore() -> void:
	update_high_score_value()
