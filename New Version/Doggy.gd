extends CharacterBody2D
class_name Player
@export var anim: AnimatedSprite2D
@onready var machine = %PlayerStateMachine

@export var gravity = 30
@export var terminal_velocity = 1000
@export var jump_velocity = 600
@export var air_resistance = 0.15
@export var run_speed = 300


func _physics_process(_delta):
	var direction = Input.get_axis("moveleft", "moveright")
	if direction == 1:
		anim.flip_h = false
	else:
		anim.flip_h = true
		
	velocity.y = min(velocity.y, terminal_velocity)
	velocity.y += gravity
	move_and_slide()
