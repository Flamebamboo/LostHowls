extends Node

var checkpoint: Array = []

func add_checkpoint(position: Vector2):
	if !checkpoint.has(position):
		checkpoint.append(position)

func get_checkpoint():
	if checkpoint.size() > 0:
		return checkpoint[checkpoint.size() - 1]
	
		
