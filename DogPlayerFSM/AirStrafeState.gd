extends PlayerState


func s_physics_process(_delta):
	
	# Check if the player is on the floor to transition to RunState
	if owner.is_on_floor():
		machine.transition_to(machine.states["RunState"])
		return

	# Get input for left and right movement
	var direction = Input.get_axis("moveleft", "moveright")
	physics.horizontal_air_resistance()
	# Change state to AirState if there is no directional input
	if direction == 0:
		machine.transition_to(machine.states["AirState"])
		return
		
		
	


