extends PlayerState
class_name AirState
func s_physics_process(_delta):

	var direction = Input.get_axis("moveleft", "moveright")

	if direction != 0:
		machine.transition_to(machine.states["AirStrafeState"])
		return

	# Apply air resistance to the player's horizontal velocity
	player.velocity.x = (player.velocity.x - (player.velocity.x * player.air_resistance))

	# Check if player is on the floor to transition to IdleState
	if player.is_on_floor(): # IDLE CONDITION
		machine.transition_to(machine.states["IdleState"])
		return


