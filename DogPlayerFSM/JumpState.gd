extends PlayerState


func _unhandled_input(event):
	if owner.is_on_floor():
		if event is InputEvent:
			# Check for jump action and player's ability to jump
			if event.is_action_pressed("moveup"):
				physics.jumps()
				machine.transition_to(machine.states["JumpState"])  # Change state to JumpState
				machine.transition_to(machine.states["AirState"])  # Change state to AirState


	
