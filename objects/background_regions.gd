extends Node2D

var backgrounds: Array[BackgroundRegion] = []


func _ready():
	for node in get_children():
		if node is BackgroundRegion:
			backgrounds.push_back(node)
			node.reached_end.connect(region_reached_end)


func distance_sum(accum: float, bg: BackgroundRegion):
	return accum + bg.lenght + bg.position.x


func region_reached_end(region: BackgroundRegion):
	region.position.x = (len(backgrounds) - 1) * region.lenght
