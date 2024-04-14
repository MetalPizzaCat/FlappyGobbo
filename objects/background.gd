extends Node2D
class_name BackgroundRegion

signal reached_end(background)

@export var speed: float = 50
@export var lenght : float = 1096
@onready var game_state_manager: GameStateManager = get_node("/root/GameState")


func _physics_process(delta):
	if not game_state_manager.is_game_running:
		return
	position.x -= speed * delta
	if position.x <= -lenght:
		reached_end.emit(self)
