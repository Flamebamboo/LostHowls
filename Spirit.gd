extends CharacterBody2D

@export var dog: CharacterBody2D
@export var shootingMarker: Marker2D
@export var bulletScene: PackedScene
@export var SPEED = 200.0
@export var FOLLOW_DISTANCE = 200.0  
@export var STOP_DISTANCE = 100.0 
@export var FOLLOW_SPEED = 0.01  
func _physics_process(delta):
	if dog:
		var target_position = dog.global_position
		var distance_to_player = global_position.distance_to(target_position)

		if distance_to_player > FOLLOW_DISTANCE:
			var direction = (target_position - global_position).normalized()
			global_position += direction * SPEED * delta
		elif distance_to_player > STOP_DISTANCE:
			# Smooth follow using lerp
			global_position = global_position.lerp(target_position, FOLLOW_SPEED)

		
		
		if Input.is_action_just_pressed("attackL") or Input.is_action_just_pressed("attackR"):
			for body in $Gun.get_overlapping_bodies():
				if body.is_in_group("enemies"):
					shoot()
					print("shoot")
					break 
				

func shoot():
	if shootingMarker:
		for enemy in get_tree().get_nodes_in_group("enemies"):
			var new_bullet = bulletScene.instantiate()
			new_bullet.global_position = shootingMarker.global_position
			var direction = (enemy.global_position - shootingMarker.global_position).normalized()
			new_bullet.velocity = direction * new_bullet.speed
			
			get_tree().root.add_child(new_bullet)
	
