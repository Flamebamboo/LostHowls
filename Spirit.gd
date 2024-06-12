extends CharacterBody2D

@export var dog: CharacterBody2D

const SPEED = 200.0
const FOLLOW_DISTANCE = 200.0  
const STOP_DISTANCE = 100.0 
const FOLLOW_SPEED = 0.01  


func _physics_process(delta):
	if dog:
		var target_position = dog.global_position
		var distance_to_player = global_position.distance_to(target_position)

		if distance_to_player > FOLLOW_DISTANCE:
			var direction = (target_position - global_position).normalized()
			global_position += direction * SPEED * delta
		elif distance_to_player > STOP_DISTANCE:
			#smooth follow using lerp
			global_position = global_position.lerp(target_position, FOLLOW_SPEED)



