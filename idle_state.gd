extends NodeState

@export var characterBody : CharacterBody2D
@export var animatedSprite : AnimatedSprite2D
@export var slowSpeed : int = 50

func on_process(delta : float):
	pass

func _physics_process(delta : float):
	characterBody.velocity.x = move_toward(characterBody.velocity.x, 0, slowSpeed * delta)
	animatedSprite.play("idle")
	characterBody.move_and_slide()
func enter():
	pass

func exit():
	pass
	
