extends PlayerState

const glide_gravity :int = 100
const glide_thrust: int = 150
const max_y_speed : int = 600
const max_x_speed: int = 300

func s_activate():
	super()
	can_glide = true
	physics.velocity.y = 0 
	print("glide entered")
	Global.current_glide = true
func s_physics_process(delta):
	
	if Input.is_action_just_released("glide"):
		await get_tree().create_timer(0.2).timeout
		machine.transition_to(machine.states["AirState"])
	gliding_physics(delta)
	
		
		
		
	
	if owner.is_on_floor() && machine.active_state.can_idle: # IDLE CONDITION
		machine.transition_to(machine.states["IdleState"])
		return
	
func gliding_physics(delta):
	
	var direction: int
	if owner.anim.flip_h == true:
		direction = -1
	elif owner.anim.flip_h == false:
		direction = 1
	
	physics.velocity.y += glide_gravity * delta
	physics.velocity.x += glide_thrust * direction * delta
	if physics.velocity.y >= max_y_speed:
		physics.velocity.y = max_y_speed
		
	if physics.velocity.x >= max_x_speed:
		physics.velocity.x = max_x_speed
