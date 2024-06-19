extends CharacterBody2D
class_name spirit
@export var dog: CharacterBody2D
@export var shootingMarker: Marker2D
@export var bulletScene: PackedScene


@export var SPEED = 300.0 #normal speed of spirit to follow dog
@export var FOLLOW_DISTANCE = 200.0  #this var is the distance between the spirit and the player
@export var STOP_DISTANCE = 100.0  #this var is used to check if the spirit distance is greater than 100 
@export var DECEL_SPEED = 0.01 #if the spirit distance is greater than 100 then this slower speed
var can_launch: bool
var can_shoot: bool

var playerlauncher : PackedScene = preload("res://playerlauncher.tscn")
func _ready():
	can_launch = true
	can_shoot = true
	
	
func _physics_process(delta):
	if dog:
		var target_position = dog.global_position
		var distance_to_player = global_position.distance_to(target_position)
		#if distance to player is greater than 200 than it starts to follow
		if distance_to_player > FOLLOW_DISTANCE:
			var direction = (target_position - global_position).normalized()
			global_position += direction * SPEED * delta
		#if distance to player is greater than stop distance it move with slow speed towards dog
		elif distance_to_player > STOP_DISTANCE:
			# Smooth follow using lerp
			global_position = global_position.lerp(target_position, DECEL_SPEED)

		
	if can_shoot:
		if Input.is_action_just_pressed("attackL"):
			for body in $Gun.get_overlapping_bodies():
				print(body)
				if body.is_in_group("enemies") or body.is_in_group("breakable objects"):
					shoot()
					await get_tree().create_timer(0.3).timeout
					shoot()
					can_shoot = false
					await get_tree().create_timer(0.6).timeout
					can_shoot = true 
					break 
		if can_launch:
			if Input.is_action_just_pressed("attackR"):
				launch()
				can_launch = false
				await get_tree().create_timer(5).timeout
				can_launch = true
				
		

func shoot():
	var instance = bulletScene.instantiate()
	if not shootingMarker:
		return
	
	var closestEntity = null
	var closestDistance = INF
	var groups =  ["enemies", "breakable objects"]
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
