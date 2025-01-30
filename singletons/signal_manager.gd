extends Node

signal on_level_selected(level_num: int)
signal on_game_exit_pressed
signal on_selection_enabled
signal on_selection_disabled
signal on_tile_selected(tile: MemoryTile)
signal on_game_over(lvl: int, moves: int)
signal on_update_highscore
signal on_credits_button_pressed
