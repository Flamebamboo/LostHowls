extends CharacterBody2D
class_name spirit
@export var shooting_marker: Marker2D
@onready var dog: Player

#Player launcher im not sure if its a great addition to the game, avoid scope creep 


@onready var bullet_scene: PackedScene = preload("res://Scenes/spirit_bullet.tscn")
#@onready var player_launcher : PackedScene = preload("res://Scenes/playerlauncher.tscn")

@export var speed: float = 300.0 
@export var follow_distance: float = 100.0  
@export var stop_distance: float = 50.0  
@export var decel_speed: float = 0.01 
var can_launch: bool
var can_shoot: bool

###logical explanations 
#Basically say if the spirit distance relative to the player is further than the follow distance 
#then chase is executed to the player postiion
#Then if distance to player is greater then stop_distance we will use mathmetical functions to smooth out the movement and decelerate

# when dog is run state spirit chase with normal speed, then if th edog enters idle state spirit will go to the target position slowly and start orbit movement
# I had to use basic trigonometry like sin and cos, eg, Sin to calculate y axis, and Cos to calculate x axis i have written the equations in my book to achieve this circular motions
# However godot has builtin method to solve this trig equations for us!!! it is from_angle, docs for more explanations, creates a unit of vector2 and rotate to the given angle
# so i did like ( Vector2.from_angle(angle) * radius ) instead of (var x_pos = cos(angle)) and (var y_pos = sin(angle))
		
##Issues
#this script I just realised the issue with the shooting mechanic, thanks to the feedback from the Google form.
#The problem was that I created the spirit (green ghost) body to be non-collidable. Although this isn’t ideal with the current Spirit algorithm, when the shoot input is registered and the Spirit is inside collision tilemaps, 
#the bullet is actually coming out but collides with the inside tile, making it not visible, which causes a “BUG.”


##What I did 24jul
#I will make the dog’s current active state a singleton so that the spirit can access this information globally. For example, when the dog’s current state is idle, 
#the spirit will also be in an idle state but will move above the dog to ensure it doesn’t overlap with anything before can_shoot is enabled. 
#currently Spirit logic isn’t very robust. 





var angle: float = 0.0
var radius: float = 3.0
var idle_speed: float = 3.0
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
	var target_position = dog.global_position + Vector2(0, -follow_distance) #local variables which i copied and paste for spirit_move aswell 
	var distance_to_player = global_position.distance_to(target_position) # for some reason if i made it outside dog return nulls
	if distance_to_player >= stop_distance: # so if distance to player is greater then stop distance meaning further then stop distance than we use lerp for to go to target position with decelleration
		global_position = global_position.lerp(target_position, decel_speed)
	#elif distance_to_player <= stop_distance: #if distance to player is less than or equal  to stop distance meaning it has reached the stop distance it will start orbit movement 
		
	angle += idle_speed * delta #circular motions 
	position = position + ( Vector2.from_angle(angle) * radius ) #circular  motion equations
	#
	
	
	
func spirit_move(delta):
	var target_position = dog.global_position + Vector2(0, -follow_distance) #same as top
	var distance_to_player = global_position.distance_to(target_position) #same as top
	var direction = (target_position - global_position).normalized() #normalizing the vector and making the spirit go to the target by substracting
	if distance_to_player >  follow_distance: #if distance is greater than follow distance we go normal speed
		global_position += direction * speed * delta
	elif distance_to_player > stop_distance: #slow speed starts
		global_position = global_position.lerp(target_position, decel_speed) # smooth follow using linear interpolation 
		
	
	
	
	

		
		## still in development
			
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
	SoundManager.PlayShootSound()
	
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
