extends PlayerState


func _unhandled_input(event):
	if owner.is_on_floor():
		if event is InputEvent:
			# Check for jump action and player's ability to jump
			if event.is_action_pressed("moveup") and machine.active_state.can_jump:
				physics.velocity.y = -physics.jump_velocity  # Set player's vertical velocity for jumping
				machine.transition_to(machine.states["JumpState"])  # Change state to JumpState
				machine.transition_to(machine.states["AirState"])  # Change state to AirState
