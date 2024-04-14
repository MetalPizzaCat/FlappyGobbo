extends Node2D
class_name PipeManager

var pipes : Array[Pipe] = []

func _ready():
	for child in get_children():
		if child is Pipe:
			pipes.push_back(child)

func restart():
	pass

