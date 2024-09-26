extends PlayerState


@onready var raycast_l: RayCast2D = $"../../RaycastL"

@onready var raycast_r: RayCast2D = $"../../RaycastR"

var is_colliding: bool 
func s_activate():
	super()
	#can_run = true
	#can_jump = true
	can_idle = true
	can_jump = true
	
func s_physics_process(_delta):
	if !owner.is_on_floor():
			machine.transition_to(machine.states["AirState"])
			return	
			
			
	if Input.is_action_pressed("pushbox") && raycast_r.is_colliding() or raycast_l.is_colliding():
		push_accel(_delta)
		
	else:
		machine.transition_to(machine.states["IdleState"])
		
	if Input.is_action_pressed("moveup") && machine.active_state.can_jump:
		machine.transition_to(machine.states["JumpState"])
	
	
func push_accel(delta: float = get_physics_process_delta_time()):
	var input_axis = Input.get_axis("moveleft", "moveright")
	physics.velocity.x = lerp(physics.velocity.x, input_axis * physics.push_speed, physics.push_acceleration * delta)
