extends CharacterBody2D
class_name spirit
@export var dog: CharacterBody2D
@export var shooting_marker: Marker2D


#Player launcher im not sure if its a great addition to the game, avoid scope creep 


@onready var bullet_scene: PackedScene = preload("res://Scenes/spirit_bullet.tscn")
#@onready var player_launcher : PackedScene = preload("res://Scenes/playerlauncher.tscn")

@export var speed = 300.0 #normal speed of spirit to follow dog
@export var follow_distance = 200.0  #this var is the distance between the spirit and the player
@export var stop_distance = 100.0  #this var is used to check if the spirit distance is greater than 100 
@export var decel_speed = 0.01 #if the spirit distance is greater than 100 then this slower speed
var can_launch: bool
var can_shoot: bool

func _ready():
	can_launch = true
	can_shoot = true

func _physics_process(delta):
	if dog:
		var target_position = dog.global_position
		var distance_to_player = global_position.distance_to(target_position)
		#if distance to player is greater than 200 than it starts to follow
		if distance_to_player > follow_distance:
			var direction = (target_position - global_position).normalized()
			global_position += direction * speed * delta
		#if distance to player is greater than stop distance it move with slow speed towards dog
		elif distance_to_player > stop_distance:
			# smooth follow using linear interpolation 
			global_position = global_position.lerp(target_position, decel_speed)

		
	if can_shoot:
		if Input.is_action_just_pressed("attackL"):
			shoot()
			can_shoot = false
			await get_tree().create_timer(0.1).timeout
			can_shoot = true 
			
		#if can_launch:
			#if Input.is_action_just_pressed("attackr"):
				#launch()
				#$launcher/canvaslayer/animationplayer.play("paw")
				#can_launch = false
				#await get_tree().create_timer(5).timeout
				#$launcher/canvaslayer/animationplayer.play("enabled")
				#can_launch = true
				
func shoot():
	var spawned_bullet := bullet_scene.instantiate()
	var mouse_direction := get_global_mouse_position() - shooting_marker.global_position
	get_tree().root.call_deferred("add_child", spawned_bullet)
	spawned_bullet.global_position = shooting_marker.global_position
	spawned_bullet.rotation = mouse_direction.angle()
	spawned_bullet.velocity = mouse_direction * spawned_bullet.speed

##still in development 
#func launch():
	#if shooting_marker and dog:
			#var new_launcher = player_launcher.instantiate()
			#new_launcher.global_position = shooting_marker.global_position
			#var direction = (dog.global_position - shooting_marker.global_position).normalized()
			#new_launcher.velocity = direction * new_launcher.speed
			#new_launcher.look_at(dog.global_position)	
			#print(new_launcher.global_position)
			#
			#get_tree().root.call_deferred("add_child", new_launcher)
			#
#
