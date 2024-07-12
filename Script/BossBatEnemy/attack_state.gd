extends BossBatState

@export var node_finite_state_machine : StateMachine
@export var characterBody: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D
@export var animation: AnimationPlayer
@export var speed: int

@export var rotate_speed = 0
@export var shooter_timer_wait_time = 3
@export var spawn_point_count = 8
const radius = 100
@onready var rotater = %Rotater
@onready var shoottimer = %shoottimer
#var batbullet = preload("res://scene/batbullet.tscn")
#



var dog: CharacterBody2D



func enter():
	dog = Global.dogCharacter
	animation.play("attack")
	animatedSprite.play("attack")
	shoottimer.stop()
	if dog:
		var direction: int
		if characterBody.global_position > dog.global_position:
			animatedSprite.flip_h = false
			direction = -1
		elif characterBody.global_position < dog.global_position:
			animatedSprite.flip_h = true
			direction = 1 
			#Flipping
		
		if characterBody.global_position.y > dog.global_position.y:
			direction = -1
		elif characterBody.global_position.y < dog.global_position.y:
			direction = 1

	
		var charge_direction = (dog.global_position - characterBody.global_position).normalized()
		var charge_speed = 300  
		characterBody.velocity = charge_direction * charge_speed
		await get_tree().create_timer(1.5).timeout
		node_finite_state_machine.transition_to("idle")
	else:
		# If dog is not found, switch to idle
		node_finite_state_machine.transition_to("idle")

func _ready():
	#2*pi is 360 deg divided by 8 so each spawnpoint is 45deg apart
	var step = 2 * PI / spawn_point_count
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.rotation = pos.angle()
		spawn_point.position = pos
		rotater.add_child(spawn_point) # spawn_point will add as rotater child so it will follow along with the rotatation of the rotator

	
	
	
func _physics_process(delta: float):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)
	
	

func exit():
	shoottimer.wait_time = shooter_timer_wait_time #timing/intervals of bullet iinstance cycle
	shoottimer.start()



func _on_shoottimer_timeout():
	for s in rotater.get_children():
		var bullet = batbullet.instantiate()
		get_tree().root.add_child(bullet)
		bullet.global_position = s.global_position
		bullet.rotation = s.global_rotation
