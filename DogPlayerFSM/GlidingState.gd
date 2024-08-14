extends PlayerState

@export var glide_gravity :int = 100
@export var max_glide_speed : int = 600
func s_activate():
	super()
	can_glide = true
	physics.velocity.y = 0
	print("glide entered")
	Global.current_glide = true
func s_physics_process(delta):
	var direction = Input.get_axis("moveleft", "moveright")
	
	if Input.is_action_just_released("glide"):
		machine.transition_to(machine.states["AirState"])

	physics.velocity.y += glide_gravity * delta
	if physics.velocity.y > max_glide_speed:
		physics.velocity.y = max_glide_speed
			
			
		
	physics.horizontal_air_strafe(delta)	

	print(owner.velocity.y)
	
	
	
	if owner.is_on_floor() && machine.active_state.can_idle: # IDLE CONDITION
		machine.transition_to(machine.states["IdleState"])
		return
	
	
