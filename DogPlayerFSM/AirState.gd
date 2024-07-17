extends PlayerState


	
func s_physics_process(_delta):
	var direction = Input.get_axis("moveleft", "moveright")
	
	if physics.can_jump() and Input.is_action_just_pressed("moveup"):
		physics.jumps()
		
	physics.vertical_air_resistance(_delta)
		
	if direction != 0:
		machine.transition_to(machine.states["AirStrafeState"])
		return
	
	

	
	# Check if player is on the floor to transition to IdleState
	if owner.is_on_floor(): # IDLE CONDITION
		machine.transition_to(machine.states["IdleState"])
		return


