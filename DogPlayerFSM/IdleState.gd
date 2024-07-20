extends PlayerState

func _init():
	pass

func s_activate():
	physics.velocity.y = 1
	
	
func s_physics_process(_delta):
	#print("velocity", physics.velocity.y)
	physics.ground_decel(_delta)
	
	var direction = Input.get_axis("moveleft", "moveright")
	
	if direction != 0:
		machine.transition_to(machine.states["RunState"])
		
