extends PlayerState

func s_physics_process(_delta):
	var direction = Input.get_axis("moveleft", "moveright")
	
	physics.vertical_air_resistance()
		
	if direction != 0:
		machine.transition_to(machine.states["AirStrafeState"])
		return
	
	# Apply air resistance to the player's horizontal velocity

	
	# Check if player is on the floor to transition to IdleState
	if owner.is_on_floor(): # IDLE CONDITION
		machine.transition_to(machine.states["IdleState"])
		return


