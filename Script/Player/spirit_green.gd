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
var playerlauncher : PackedScene = preload("res://Scenes/playerlauncher.tscn")
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
			# Smooth follow using linear interpolation 
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
				$launcher/CanvasLayer/AnimationPlayer.play("paw")
				can_launch = false
				await get_tree().create_timer(5).timeout
				$launcher/CanvasLayer/AnimationPlayer.play("enabled")
				can_launch = true
				
func shoot():
	var spawned_bullet := bulletScene.instantiate()
	var mouse_direction := get_global_mouse_position() - shootingMarker.global_position
	get_tree().root.call_deferred("add_child", spawned_bullet)
	spawned_bullet.global_position = shootingMarker.global_position
	spawned_bullet.rotation = mouse_direction.angle()
	spawned_bullet.velocity = mouse_direction * spawned_bullet.speed

func launch():
	if shootingMarker and dog:
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
