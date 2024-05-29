extends Node

@export var characterBody : CharacterBody2D
@export var animatedSprite :  AnimatedSprite2D

const gravity : int = 10000

func _physics_process(delta):
	if !characterBody.is_on_floor():
		characterBody.velocity.y =+ gravity * delta
	
	characterBody.move_and_slide()
