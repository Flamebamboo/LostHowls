extends AnimatableBody2D

@export var move_distance: float = 100.0

var move_right: bool

func _input(event):
	if event.is_action_pressed("pushbox"):  # Assuming "ui_select" is the action to trigger the move
		move_object()

func move_object():
	var direction = Vector2.RIGHT 
	if move_right:
		direction = Vector2.RIGHT 
	else:
		direction = Vector2.LEFT 
	
	
	var target_position = position + direction * move_distance

	position = target_position
	
	move_right = not move_right
