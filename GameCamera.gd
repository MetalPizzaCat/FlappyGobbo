extends Camera2D

@export var target : Node2D

func _process(_delta):
	if target != null:
		position.x = target.position.x