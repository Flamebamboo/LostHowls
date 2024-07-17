extends PlayerState


	
func s_physics_process(_delta):
	var direction = Input.get_axis("moveleft", "moveright")
	
	physics.apply_gravity()
	if physics.can_jump() and Input.is_action_just_pressed("moveup"):
		physics.jumps()
	
	physics.vertical_air_resistance(_delta)
	physics.horizontal_air_strafe(_delta)	
	
	if owner.is_on_floor(): # IDLE CONDITION
		machine.transition_to(machine.states["IdleState"])
		return


