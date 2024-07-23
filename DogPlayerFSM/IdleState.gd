extends PlayerState

func _init():  #Called once when the object is created.
	pass

func s_activate(): #Called every time the state is entered.
	physics.velocity.y = 1
	super()
	can_jump = true
	can_run = true
	Global.current_idle = true
	
	
func s_physics_process(_delta):

	physics.ground_decel(_delta)
	
	var direction = Input.get_axis("moveleft", "moveright")
	
	if direction != 0 && machine.active_state.can_run:
		machine.transition_to(machine.states["RunState"])
		

func input(event : InputEvent):
	if event.is_action_pressed("moveup") && machine.active_state.can_jump:
		machine.transition_to(machine.states["JumpState"])
		
func s_deactivate():
	Global.current_idle = false	

		
