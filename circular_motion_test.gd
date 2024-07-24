extends Node2D

var angle: float = 0.0
var radius: float = 1
var x_offset: float = 120
var y_offset: float = 120
var idle_speed: float = 1.5

func _process(delta):
	angle += idle_speed * delta
	var x_pos = cos(angle)
	var y_pos = sin(angle)
	
	position.x = radius * x_pos * x_offset
	position.y = radius * y_pos * y_offset
