extends CharacterBody2D

@export var health : Health 
@export var hurtbox: Hurtbox


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	#apply_gravity(delta)
	
	move_and_slide()
	
#func apply_gravity(delta):
	#if not is_on_floor():
		#velocity.y += gravity * 30 * delta
