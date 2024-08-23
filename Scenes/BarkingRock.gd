#extends AnimatableBody2D
#
#@export var move_distance: float = 100.0
#
#var move_right: bool
#
#func _physics_process(delta):
	#if Input.is_action_just_pressed("pushbox"):
		#move_object(delta)
#
#func move_object(delta):
	#var direction = Vector2.RIGHT 
	#if move_right:
		#direction = Vector2.RIGHT 
	#else:
		#direction = Vector2.LEFT 
	#
	#
	#var target_position = position + direction * move_distance 
	#var new_position = (target_position - position).normalized() 
#k	position = position.move_toward(new_position, delta)
	#
#
	#move_right = not move_right
