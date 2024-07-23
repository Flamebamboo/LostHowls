extends PlayerState
###this is air state
signal floor

@onready var coyote_time = %"Coyote Time"
 

func s_activate():
	var just_left_edge = !owner.is_on_floor() and owner.velocity.y >= 0 #going downward check >=
	if just_left_edge:
		coyote_time.start()	
	super()
	can_jump = true
	can_idle = true
	Global.current_air = true
	
	
func s_physics_process(_delta):
	var direction = Input.get_axis("moveleft", "moveright")
	
	physics.apply_gravity()
	
	physics.vertical_air_resistance(_delta)
	physics.horizontal_air_strafe(_delta)	
	
	if owner.is_on_floor() && machine.active_state.can_idle: # IDLE CONDITION
		machine.transition_to(machine.states["IdleState"])
		return


func s_deactivate():
	Global.current_air = false

func _input(event : InputEvent):
	if event.is_action_pressed("moveup") && coyote_time.time_left > 0 && physics.can_double_jump() && machine.active_state.can_jump:
		machine.transition_to(machine.states["JumpState"])
		emit_signal('floor')
