extends PlayerState
#const PULL_FORCE: float = 30.0

@onready var raycast_l: RayCast2D = $"../../RaycastL"
@onready var raycast_r: RayCast2D = $"../../RaycastR"

func s_activate():
	super()
	can_run = true
	can_jump = true
	can_idle = true

func s_physics_process(_delta):
	if !owner.is_on_floor():
			machine.transition_to(machine.states["AirState"])
			return
	
	if Input.is_action_pressed("pullbox") && raycast_l.is_colliding() or raycast_r.is_colliding():
		pull_accel(_delta)
		
	else:
		machine.transition_to(machine.states["IdleState"])

func pull_accel(delta: float = get_physics_process_delta_time()):
	var input_axis = Input.get_axis("moveleft", "moveright")
	physics.velocity.x = lerp(physics.velocity.x, input_axis * physics.pull_speed, physics.pull_acceleration * delta)
