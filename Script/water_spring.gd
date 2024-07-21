extends Node2D

var velocity = 0 
var force = 0
var height = 0

#the natural position of the spring
var target_height = 0


func water_update(spring_dampening, spring_stiffness):
	#this function applies the hooke's law force to the spring 

	height = position.y
	
	#the spring current extentions
	var spring_extention = height - target_height

	var loss = -spring_dampening * velocity
	#hooke's law (F = -K * X)

	force = -spring_stiffness * spring_extention + loss

	velocity += force
	
	position.y += velocity


	


func initialize(x_position):
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position
