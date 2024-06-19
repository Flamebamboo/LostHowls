extends Node

@export var characterBody : CharacterBody2D
@export var animatedSprite :  AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	if !characterBody.is_on_floor():
		characterBody.velocity.y =+ gravity * delta
	
	characterBody.move_and_slide()
