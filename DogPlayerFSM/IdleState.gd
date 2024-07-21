extends PlayerState

func _init():
	pass

func s_activate():
	physics.velocity.y = 1
	
	
	
func s_physics_process(_delta):

	physics.ground_decel(_delta)
	
	var direction = Input.get_axis("moveleft", "moveright")
	
	if direction != 0:
		machine.transition_to(machine.states["RunState"])
		

func input(event : InputEvent):
	if event.is_action_pressed("jump"):
		machine.transition_to(machine.states["JumpState"])
	
	elif physics.direction == 0  && owner.is_on_floor():
		machine.transition_to(machine.states["IdleState"])
		
