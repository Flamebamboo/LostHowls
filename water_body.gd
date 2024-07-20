extends Node2D

@export var spring_stiffness = 0.015
@export var spring_dampening = 0.03

@export var spread = 0.0002

var springs = []

func _ready():
	for i in get_children():
		spring.append(i)
		i.initialize

func _physics_process(delta):
	for i in springs:
		i.water_update(spring_stiffness, spring_dampening)

	#array will store difference in height between each spring and its left neighbour
	var left_deltas = []

	#array will store the difference in height between each spring and its right neigbour
	var right_deltas = []
