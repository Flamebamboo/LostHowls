extends PlayerState

func _init():
	pass

func s_activate():
	physics.velocity.y = 1
	
	
	if machine.active_state.can_fall:
		owner.velocity = Vector2(0, 0)  # Reset if fall
	
	can_jump = true
	can_run = true
	
func s_physics_process(_delta):
	
	physics.ground_decel(_delta)
	
	var direction = Input.get_axis("moveleft", "moveright")
	
	if direction != 0:
		machine.transition_to(machine.states["RunState"])
		

