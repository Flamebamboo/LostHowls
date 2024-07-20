extends Node2D

@export var spring_stiffness = 0.015
@export var spring_dampening = 0.03

@export var spread = 0.0002


@export var distance_between_springs = 32

@export var spring_number = 6

#total body length
var water_length = distance_between_springs * spring_number
var passes = 8
var springs = []

#i is child nodes of this waterbody parent

func _ready():
	for i in get_children():
		springs.append(i)
		i.initialize  #calling the child node initialize

func _physics_process(delta):
	for i in springs: #looping each springs in the springs array
		i.water_update(spring_stiffness, spring_dampening)

	#array will store difference in height between each spring and its left neighbour
	var left_deltas = []

	#array will store the difference in height between each spring and its right neigbour
	var right_deltas = []
	
	for i in range (springs.size()): #initialiaze the arrays with zero
		left_deltas.append(0) 
		right_deltas.append(0)
	
	for j in range(passes):
		#velocity to the left of the current spring
		for i in range (springs.size()):
		
			if i > 0:
				left_deltas[i] = spread * (springs[i].height - springs[i-1].height)
				springs[i-1].velocity += left_deltas[i]
				#[i-1] means left of the array


			if i < springs.size()-1: #This condition checks if the current index i is less than the last index in the array.
				right_deltas[i] = spread * (springs[i].height - springs[i+1].height)
				springs[i+1].velocity += right_deltas[i]
				#[i-1] means right of the array
		#velocity to the right of the current spring

func splash(index, speed):
	if index >= 0 and index < springs.size():
		springs[index].velocity += speed
