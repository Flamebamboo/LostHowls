
extends NodeState
@export var node_finite_state_machine : NodeFiniteStateMachine
@export var characterBody: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D
@export var speed: int

@export var rotate_speed = 0
@export var shooter_timer_wait_time = 3
@export var spawn_point_count = 8
const radius = 100
@onready var rotater = %Rotater
@onready var shoottimer = %shoottimer
var batbullet = preload("res://batbullet.tscn")




var dog: CharacterBody2D
var attack: bool
func enter():
	dog = Global.dogCharacter
	animatedSprite.play("attack")
	attack = true
	
func _ready():
	var step = 2 * PI / spawn_point_count
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.rotation = pos.angle()
		spawn_point.position = pos
		rotater.add_child(spawn_point)

	shoottimer.wait_time = shooter_timer_wait_time
	shoottimer.start()
	
	
func _physics_process(delta: float):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)
	#if dog:
		#var direction: int
		#if characterBody.global_position.x > dog.global_position.x:
			#animatedSprite.flip_h = false
			#direction = -1
		#elif characterBody.global_position.x < dog.global_position.x:
			#animatedSprite.flip_h = true
			#direction = 1 
			#Flipping

		#characterBody.velocity.x = direction * speed
		#characterBody.velocity.x = clampf(characterBody.velocity.x, -speed, speed)
		#characterBody.move_and_slide()
	#else:
		# If dog is not found, switch to idle
		#node_finite_state_machine.transition_to("idle")

func exit():
	characterBody.velocity = Vector2.ZERO
	animatedSprite.stop()




func _on_shoottimer_timeout():
	for s in rotater.get_children():
		var bullet = batbullet.instantiate()
		get_tree().root.add_child(bullet)
		bullet.global_position = s.global_position
		bullet.rotation = s.global_rotation
