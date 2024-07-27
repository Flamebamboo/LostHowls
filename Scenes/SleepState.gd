extends BossBatState

func s_activate():
	owner.global_position = Vector2(3407, -113)
	
func s_process(_delta):
	bossbat.velocity = Vector2.ZERO
	bossbat.move_and_slide()
