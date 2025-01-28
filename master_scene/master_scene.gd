extends CanvasLayer

@onready var main_screen = $MainScreen
@onready var game_screen = $GameScreen
@onready var sound = $Sound

# Called when the node enters the scene tree for the first time.
func _ready():
	on_game_exit_pressed()
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)
	SignalManager.on_level_selected.connect(on_level_selected)
	SignalManager.on_game_over.connect(on_game_over)

func show_game(s: bool) -> void:
	game_screen.visible = s
	main_screen.visible = !s

func on_game_exit_pressed() -> void:
	show_game(false)
	GameManager.clear_nodes_of_group(GameManager.GROUP_TILE)
	SoundManager.play_exit_button_click(sound)
	SoundManager.play_sound(sound, SoundManager.SOUND_MAIN_MENU)

func on_level_selected(level_num: int) -> void:
	show_game(true)
	SoundManager.play_sound(sound, SoundManager.SOUND_IN_GAME)
	
func on_game_over(lvl: int, moves: int) -> void:
	SoundManager.play_sound(sound, SoundManager.SOUND_GAME_OVER)
	
	var high_score = GameManager.get_high_score(lvl);
	if moves < high_score or high_score == 0:
		GameManager.set_high_score(lvl, moves)
		GameManager.save_high_score_to_file()
