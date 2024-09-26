extends PlayerState



func s_activate(): #Called every time the state is entered.
	super()
	physics.apply_gravity()
	await get_tree().create_timer(1).timeout
	machine.transition_to(machine.states["AirState"])
	
	
func s_physics_process(delta):
	physics.vertical_air_resistance(delta)
	physics.ground_decel(delta)
	physics.velocity.y += 80
	


		
