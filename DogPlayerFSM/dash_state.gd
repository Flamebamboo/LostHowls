extends PlayerState

var tick: float 

func s_activate():
	super() #calling to base func
	can_dash = true
	
	
func s_physics_process(_delta):
	#tick += 1 
	if Input.is_action_just_pressed("dash") && machine.active_state.can_dash:
		owner.velocity.x = physics.max_speed * physics.speed_multiplier 
		owner.velocity.y = 0
	elif physics.input_axis: physics.input_axis * physics.max_speed
		
	#else:
		#owner.velocity.x = move_toward(owner.velocity.x, 0, physics.max_speed)
		#
	#if tick >= 200:
		#machine.transition_to(machine.states["IdleState"])
		
	
func s_deactivate():
	pass
