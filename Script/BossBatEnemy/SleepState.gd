extends BossBatState
#sleep only activate when start
func s_activate():
	owner.global_position = Vector2(3407, -113)
	
func s_process(_delta):
	owner.velocity = Vector2.ZERO
	owner.move_and_slide()
