extends PlayerState


func s_activate():
	super()
	Global.current_run = true
	

func s_process(_delta):
	pass

func s_physics_process(_delta):
	var direction = Input.get_axis("moveleft", "moveright")
	if direction != 0 :
		if !owner.is_on_floor():
			machine.transition_to(machine.states["AirState"])
			return	

		physics.ground_accel(_delta)
		
	else:
		machine.transition_to(machine.states["IdleState"])

	if Input.is_action_pressed("moveup") && machine.active_state.can_jump:
		machine.transition_to(machine.states["JumpState"])

	if Input.is_action_just_pressed("pushbox") && machine.active_state.can_push:
		machine.transition_to(machine.states["PushingState"])
		
	if !Global.dogAlive:
		machine.transition_to(machine.states["DeadState"])
func s_deactivate():
	Global.current_run = false
