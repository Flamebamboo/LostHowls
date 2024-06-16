extends CharacterBody2D
class_name spirit
@export var dog: CharacterBody2D
@export var shootingMarker: Marker2D
@export var bulletScene: PackedScene
@export var SPEED = 200.0
@export var FOLLOW_DISTANCE = 200.0  
@export var STOP_DISTANCE = 100.0 
@export var FOLLOW_SPEED = 0.01 


var playerlauncher : PackedScene = preload("res://playerlauncher.tscn")

	
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

		
		
		if Input.is_action_just_pressed("attackL"):
			for body in $Gun.get_overlapping_bodies():
				if body.is_in_group("enemies"):
					shoot()
					await get_tree().create_timer(0.3).timeout
					shoot()
					break 
		
		if Input.is_action_just_pressed("attackR"):
			launch()
		

func shoot():
	var instance = bulletScene.instantiate()
	if not shootingMarker:
		return
	
	var closestEntity = null
	var closestDistance = INF
	var groups = ["enemies", "breakable objects"]
	for group in groups:
		for entity in get_tree().get_nodes_in_group(group):
			var distance = shootingMarker.global_position.distance_to(entity.global_position)
			if distance < closestDistance:
				closestDistance = distance
				closestEntity = entity

	#closesnt entity then create a instance
	if closestEntity:
		var new_bullet = bulletScene.instantiate()
		new_bullet.global_position = shootingMarker.global_position
		var direction = (closestEntity.global_position - shootingMarker.global_position).normalized()
		new_bullet.velocity = direction * new_bullet.speed

		get_tree().root.call_deferred("add_child", new_bullet)

func launch():
	if shootingMarker:
		for dog in get_tree().get_nodes_in_group("dog"):
			var new_launcher = playerlauncher.instantiate()
			new_launcher.global_position = shootingMarker.global_position
			var direction = (dog.global_position - shootingMarker.global_position).normalized()
			new_launcher.velocity = direction * new_launcher.speed
			new_launcher.look_at(dog.global_position)	
			print(new_launcher.global_position)
			
			get_tree().root.call_deferred("add_child", new_launcher)
			
func _on_gun_area_entered(area):
	if area.is_in_group("breakable objects"):
		shoot()
		print("works")
