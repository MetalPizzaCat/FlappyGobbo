extends Node2D
class_name PipeManager

var pipes: Array[Pipe] = []

@export var distance_between_pipes: float = 112
@export var pipe_start_position : Node2D


func _ready():
	for child in get_children():
		if child is Pipe:
			pipes.push_back(child)
	restart()

func restart():
	for i in range(0,len(pipes)):
		pipes[i].reset(pipe_start_position.position.x + distance_between_pipes * i)
