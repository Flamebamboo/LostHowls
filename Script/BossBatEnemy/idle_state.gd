extends NodeState

@export var characterBody: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D

func _enter():
	characterBody.velocity = Vector2.ZERO
	animatedSprite.stop()

	
	
	
func exit():
	animatedSprite.stop()
	
