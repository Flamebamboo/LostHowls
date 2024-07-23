extends PlayerState


func s_activate():
	print("jump state")
	physics.jumps()
	super()
	can_air = true
	Global.current_jump = true
func s_physics_process(_delta):
	if !owner.is_on_floor() && machine.active_state.can_air:
		machine.transition_to(machine.states["AirState"]) 

func s_deactivate():
	Global.current_jump = false
			

	

