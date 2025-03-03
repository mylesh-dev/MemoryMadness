extends Node

class_name Scorer

@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer

var _selections: Array = []
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0
var _level_number: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)
	SignalManager.on_tile_selected.connect(on_tile_selected)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)

func on_level_selected(level_num: int) -> void:
	_level_number = level_num

func get_moves_made_str() -> String:
	return str(_moves_made)

func get_pairs_made_str() -> String:
	return "%s / %s" % [_pairs_made, _target_pairs]

func clear_new_game(target_pairs: int) -> void:
	_selections.clear()
	_pairs_made = 0
	_moves_made = 0
	_target_pairs = target_pairs

func selections_are_pair() -> bool:
	return (
		_selections[0].get_instance_id() != _selections[1].get_instance_id()
		and
		_selections[0].get_item_name() == _selections[1].get_item_name()
		)

func kill_tiles() -> void:
	for s in _selections:
		s.kill_on_success()
	_pairs_made += 1
	SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)

func update_selections() -> void:
	reveal_timer.start()
	if selections_are_pair() == true:
		kill_tiles()
	else: 
		SoundManager.play_wrong_tile_click(sound)

func check_pair_made(tile:MemoryTile) -> void:
	tile.reveal(true)
	_selections.append(tile)
	if _selections.size() != 2:
		SoundManager.play_tile_click(sound)
		return
	
	SignalManager.on_selection_disabled.emit()
	_moves_made += 1
	
	update_selections()

func hide_selections() -> void:
	for s in _selections:
		s.reveal(false)

func check_game_over() -> void:
	if _pairs_made >= _target_pairs:
		SignalManager.on_game_over.emit(_level_number, _moves_made)
		SignalManager.on_update_highscore.emit()

func on_tile_selected(tile:MemoryTile) -> void:
	if _selections.has(tile):
		return
	#SoundManager.play_tile_click(sound)
	check_pair_made(tile)


func _on_reveal_timer_timeout():
	if selections_are_pair() == false:
		hide_selections()
	_selections.clear()
	check_game_over()
	SignalManager.on_selection_enabled.emit()

func on_game_exit_pressed() -> void:
	reveal_timer.stop()
