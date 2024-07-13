extends BossBatState
@export var animatedSprite: AnimatedSprite2D

func s_activate():
	bossbat.velocity = Vector2.ZERO
	animatedSprite.stop()

	
	
	
func s_deactivate():
	animatedSprite.stop()
	
