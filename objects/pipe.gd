extends Node2D
class_name Pipe

@export var speed: float = 50
@export var max_distance_before_reset: float = -32
@export var default_x_coord: float = 528
@export var min_y: float = 75
@export var max_y: float = 160
@export var min_gap_size: float = 48
@export var max_gap_size: float = 72

@onready var top_segment: Node2D = $TopPipe

@onready var game_state_manager: GameStateManager = get_node("/root/GameState")


func reset(start: float):
	position.x = start
	position.y = randf_range(min_y, max_y)
	if top_segment != null:
		top_segment.position.y = -randf_range(min_gap_size, max_gap_size)


func _physics_process(delta):
	if not game_state_manager.is_game_running:
		return
	position.x -= speed * delta
	if position.x <= -32:
		reset(default_x_coord)


func _on_area_2d_area_entered(area:Area2D):
	if area is Goblin:
		area.add_point()
