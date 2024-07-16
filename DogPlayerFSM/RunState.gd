extends PlayerState
class_name RunState
func s_activate():
	can_jump = true

func s_deactivate():
	pass

func s_process(_delta):
	pass

func s_physics_process(_delta):
		var direction = Input.get_axis("moveleft", "moveright")
		if direction != 0 and can_run == true:
			if !owner.is_on_floor():
				machine.transition_to(machine.states["AirState"])
				return	
	
			physics.ground_accel(_delta)
			
		else:
			machine.transition_to(machine.states["IdleState"])
			
