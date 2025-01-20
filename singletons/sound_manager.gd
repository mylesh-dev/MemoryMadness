extends Node


const SOUND_MAIN_MENU = "main"
const SOUND_IN_GAME = "ingame"
const SOUND_SUCCESS = "success"
const SOUND_GAME_OVER = "gameover"
const SOUND_SELECT_TILE = "tile"
const SOUND_SELECT_WRONG_TILE = "wrong_tile"
const SOUND_SELECT_BUTTON = "button"


const SOUNDS = {
	SOUND_MAIN_MENU: preload("res://assets/sounds/JDSherbert - Ambiences Music Pack - Frost Mountain Aura.mp3"),
	SOUND_IN_GAME: preload("res://assets/sounds/JDSherbert - Minigame Music Pack - Refreshing Dawn.mp3"),
	SOUND_SUCCESS: preload("res://assets/sounds/Big Egg collect 1.wav"),
	SOUND_GAME_OVER: preload("res://assets/sounds/Balloon start riding 1.wav"),
	SOUND_SELECT_TILE: preload("res://assets/sounds/Confirm 1.wav"),
	SOUND_SELECT_WRONG_TILE: preload("res://assets/sounds/Cancel 1.wav"),
	SOUND_SELECT_BUTTON: preload("res://assets/sounds/Fruit collect 1.wav")
}

func play_sound(player: AudioStreamPlayer, key: String) -> void:
	if SOUNDS.has(key) == false:
		return
		
	player.stop()
	player.stream = SOUNDS[key]
	player.play()

func play_button_click(player: AudioStreamPlayer) -> void:
	play_sound(player, SOUND_SELECT_BUTTON)
	
func play_exit_button_click(player: AudioStreamPlayer) -> void:
	play_sound(player, SOUND_SELECT_WRONG_TILE)
	
func play_game_over_exit_button_click(player: AudioStreamPlayer) -> void:
	player.stream = SOUNDS[SOUND_SELECT_WRONG_TILE]

func play_tile_click(player: AudioStreamPlayer) -> void:
	play_sound(player, SOUND_SELECT_TILE)
	
func play_wrong_tile_click(player: AudioStreamPlayer) -> void:
	play_sound(player, SOUND_SELECT_WRONG_TILE)
