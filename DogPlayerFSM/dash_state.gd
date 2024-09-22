extends PlayerState

var tick: float 


func s_activate():
	super() #calling to base func
	can_dash = true
	physics.dash()
	
func s_physics_process(_delta):
	tick += 0.15
	
	if tick >= 0.2:
		tick = 0
		physics.ground_decel()
		machine.transition_to(machine.states["IdleState"])
		
	
func s_deactivate():
	pass
