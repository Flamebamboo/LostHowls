
extends NodeState

@export var characterBody: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D

func enter():
	animatedSprite.play("idle")

func on_process():
	pass

func _physics_process(_delta):
	characterBody.velocity = Vector2.ZERO
	characterBody.move_and_slide()

func exit():
	pass
