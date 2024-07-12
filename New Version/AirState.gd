extends PlayerState
	
func s_activate():
	pass
	
func s_deactivate():
	pass

func s_process(_delta):
	pass

func s_physics_process(_delta):
	
	var direction = Input.get_axis("moveleft", "moveright")
	player.velocity.x = (player.velocity.x - (player.velocity.x * player.air_resistance))
	
	#if player.is_on_floor():
		#machine.transition_to(machine.states["IdleState"])
		#return
