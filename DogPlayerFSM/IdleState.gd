extends PlayerState
func s_activate():
	player.velocity = Vector2(0,0)
	can_jump = true
	can_run = true
	
func s_physics_process(_delta):
	var direction = Input.get_axis("moveleft", "moveright")
	
	if direction != 0:
		machine.transition_to(machine.states["RunState"])
