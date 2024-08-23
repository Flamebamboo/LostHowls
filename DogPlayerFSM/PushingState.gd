extends PlayerState

const PUSH_FORCE: float = 50.0
const  MIN_FORCE : float = 30.0
#const max_power: float = 100.0

func s_activate():
	super()
	can_run = true
	can_jump = true
	can_idle = true

func s_physics_process(_delta):
	if !owner.is_on_floor():
			machine.transition_to(machine.states["AirState"])
			return	
	if Input.is_action_pressed("pushbox"):
		push_box()
	else:
		
		machine.transition_to(machine.states["IdleState"])
		
		
		
	

func push_box():
	for i in owner.get_slide_collision_count():
			var c = owner.get_slide_collision(i)
			if c.get_collider() is MovableRock: 
				var push_force = (PUSH_FORCE * owner.velocity.length() / physics.acceleration) + MIN_FORCE
				c.get_collider().apply_impulse(-c.get_normal() * push_force)
				



	
