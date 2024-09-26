extends AnimatableBody2D

var current_pos: Vector2
@export var amplitude: float = 100.0

@export var horizontal_movement: bool
@export var verticle_movement: bool
@export var move_speed: float = 2.0

var last_position: Vector2
@onready var activation_platform: AnimatedSprite2D = $ActivationPlatform

var rock_on_plate: bool = false
var time_passed: float = 0.0

func _ready():
	current_pos = position
	last_position = current_pos
	activation_platform.play("NotActive")
	
func _physics_process(delta: float) -> void:
	if rock_on_plate == true:
		if verticle_movement:
			time_passed += delta * move_speed #chatgpt
			# Calculate the new Y position with smooth up and down movement
			position.y = current_pos.y + sin(time_passed) * amplitude #chatgpt calculation help 
			last_position = position
			
		elif horizontal_movement:
			time_passed += delta * move_speed
			position.x = current_pos.x + sin(time_passed) * amplitude
			last_position = position
	else:
		position = last_position


func _activated_plate(): 
	rock_on_plate = true
	activation_platform.play("Active")

func _deactivated_plate():
	rock_on_plate = false
	activation_platform.play("NotActive")
