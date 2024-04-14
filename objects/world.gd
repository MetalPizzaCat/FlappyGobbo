extends Node2D
class_name GobboWorld


var is_game_running : bool = false
var is_game_finished : bool = false

@export var pipe_manager : PipeManager

@onready var game_state_manager : GameStateManager = get_node("/root/GameState")


func _on_gobbo_died():
	game_state_manager.is_game_running = false


func _on_gobbo_game_restarted():
	if pipe_manager != null:
		pipe_manager.restart()
