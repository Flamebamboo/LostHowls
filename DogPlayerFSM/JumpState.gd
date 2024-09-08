extends PlayerState


func s_activate():
	physics.jumps()
	super()
	can_air = true
	Global.current_jump = true
func s_physics_process(_delta):
	if !owner.is_on_floor() && machine.active_state.can_air:
		machine.transition_to(machine.states["AirState"]) 
	if !Global.dogAlive:
		machine.transition_to(machine.states["DeadState"])
func s_deactivate():
	Global.current_jump = false
			

	
