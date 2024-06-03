
extends NodeState
@export var node_finite_state_machine : NodeFiniteStateMachine
@export var characterBody: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D
@export var speed: int
@onready var projectile_scene = preload("res://projectiles.tscn")
var dog: CharacterBody2D
var attack: bool
func enter():
	dog = Global.dogCharacter
	animatedSprite.play("attack")
	attack = true
func on_process():
	pass

func _physics_process(_delta):
	if dog:
		var direction: int
		if characterBody.global_position.x > dog.global_position.x:
			animatedSprite.flip_h = false
			direction = -1
		elif characterBody.global_position.x < dog.global_position.x:
			animatedSprite.flip_h = true
			direction = 1

		characterBody.velocity.x = direction * speed
		characterBody.velocity.x = clamp(characterBody.velocity.x, -speed, speed)
		characterBody.move_and_slide()
	else:
		# If dog is not found, switch to idle
		node_finite_state_machine.transition_to("idle")

func exit():
	characterBody.velocity = Vector2.ZERO
	animatedSprite.stop()


