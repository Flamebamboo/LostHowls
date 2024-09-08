extends PlayerState
const PULL_FORCE: float = 30.0


func s_activate():
	super()
	can_run = true
	can_jump = true
	can_idle = true

func s_physics_process(_delta):
	if !owner.is_on_floor():
			machine.transition_to(machine.states["AirState"])
			return	
	if Input.is_action_pressed("pullbox"):
		pull_box()	
		
	else:
		machine.transition_to(machine.states["IdleState"])
		
func pull_box():
	for i in owner.get_slide_collision_count(): 
		var c = owner.get_slide_collision(i) 
		if c.get_collider() is MovableRock:
			var follow_player = (owner.global_position - c.get_collider().global_position).normalized()
			c.get_collider().apply_impulse(follow_player * PULL_FORCE)
			
