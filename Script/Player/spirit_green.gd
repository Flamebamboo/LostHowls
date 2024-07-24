extends CharacterBody2D
class_name spirit
@export var shooting_marker: Marker2D
@onready var dog: Player

#Player launcher im not sure if its a great addition to the game, avoid scope creep 


@onready var bullet_scene: PackedScene = preload("res://Scenes/spirit_bullet.tscn")
#@onready var player_launcher : PackedScene = preload("res://Scenes/playerlauncher.tscn")

@export var speed: float = 300.0 #normal speed of spirit to follow dog
@export var follow_distance: float = 100.0  #this var is the distance between the spirit and the player
@export var stop_distance: float = 100.0  #this var is used to check if the spirit distance is greater than 100 
@export var decel_speed: float = 0.01 #if the spirit distance is greater than 100 then this slower speed
var can_launch: bool
var can_shoot: bool





var angle: float = 0.0
var radius: float = 1
var x_offset: float = 120
var y_offset: float = 120
var idle_speed: float = 1.5
func _ready():
	can_launch = true
	can_shoot = true
	dog = Global.dogCharacter
	
	
func _physics_process(delta):

	if can_shoot:
		if Input.is_action_just_pressed("attackL"):
			shoot()
			can_shoot = false
			await get_tree().create_timer(0.1).timeout
			can_shoot = true 
			
	if Global.current_idle:
		spirit_idle(delta)
	elif Global.current_run || Global.current_air:
		spirit_move(delta)
	

func spirit_idle(delta):
	var target_position = dog.global_position + Vector2(0, -follow_distance)
	var distance_to_player = global_position.distance_to(target_position)
	var direction = (target_position - global_position).normalized()
	global_position = global_position.lerp(target_position, decel_speed)
	if distance_to_player <= stop_distance:
		angle += idle_speed * delta
		var x_pos = cos(angle)
		var y_pos = sin(angle)
		
		position.x = radius * x_pos * x_offset
		position.y = radius * y_pos * y_offset
	pass
	
	
	
func spirit_move(delta):
	var target_position = dog.global_position + Vector2(0, -follow_distance)
	var distance_to_player = global_position.distance_to(target_position)
	var direction = (target_position - global_position).normalized()
	#if distance to player is greater than 200 than it starts to follow
	if distance_to_player > follow_distance:
		global_position += direction * speed * delta
		#if distance to player is greater than stop distance it move with slow speed towards dog
	elif distance_to_player > stop_distance:
			# smooth follow using linear interpolation 
		global_position = global_position.lerp(target_position, decel_speed)
	
	
	
	
	

		
	
			
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
