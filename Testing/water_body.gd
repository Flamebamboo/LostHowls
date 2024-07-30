extends Node2D

@export var spring_stiffness = 0.015
@export var spring_dampening = 0.03

@export var spread = 0.0002


@export var distance_between_springs = 32

@export var spring_number = 6

@onready var water_spring = preload("res://water_spring.tscn")

#total body length
var water_length = distance_between_springs * spring_number
var passes = 8
var springs = []


@export var depth = 1000
var target_height = global_position.y
var bottom = target_height + depth

@onready var water_polygon = $Polygon2D


func _ready():
	
	spread = spread / 1000
	
	
	for i in range(spring_number):
		var x_position = distance_between_springs * i
		var water_instance = water_spring.instantiate()
		add_child(water_instance)
		springs.append(water_instance)
		water_instance.initialize(x_position)
	splash(2, 5)
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
	new_border()
	draw_water_body()
func draw_water_body():
	var surface_points = []
	
	#loop through our spring array
	#makes a new array, with the position of our points
	
	for i in range(springs.size()):
		surface_points.append(springs[i].position)
	
	var first_index = 0
	var last_index = surface_points.size()-1
	
	#the water polygon will contain all the points of the surface
	var water_polygon_points = surface_points
	
	#add other two points at the bottom of the polygon, to close the water body
	water_polygon_points.append(Vector2(surface_points[last_index].x, bottom))
	water_polygon_points.append(Vector2(surface_points[first_index].x, bottom))
	
	#transform our normal array to packedvector2array
	#the polygon draw functions 
	water_polygon_points = PackedVector2Array(water_polygon_points)
	
	water_polygon.set_polygon(water_polygon_points)

func new_border():
	var line = Line2D.new().duplicate()
	
	var surface_points = []
	
	for i in range(springs.size()):
		surface_points.append(springs[i].position)
	
	for i in range(surface_points.size()):
		line.add_point(surface_points[i])
	
	
	
	

func splash(index, speed):
	if index >= 0 and index < springs.size():
		springs[index].velocity += speed
