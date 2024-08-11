extends PlayerState

var gravity :int = 50
func s_activate():
	super()
	can_glide = true
	
func s_physics_process(delta):
	var direction = Input.get_axis("moveleft", "moveright")
	
	if Input.is_action_just_released("glide"):
		machine.transition_to(machine.states["AirState"])
	if owner.velocity.y < 0:
		physics.velocity.y += gravity
	physics.horizontal_air_strafe(delta)	
	
	
	
	if owner.is_on_floor() && machine.active_state.can_idle: # IDLE CONDITION
		machine.transition_to(machine.states["IdleState"])
		return
	
	
