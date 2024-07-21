extends PlayerState


func s_activate():
	print("jump state")
	physics.jumps()

func s_physics_process(_delta):
	if !owner.is_on_floor():
		machine.transition_to(machine.states["AirState"]) 
		

			

	

