extends PlayerState

var tick: float 
var direction

var doDash = false 
var dashDirection : int
func s_activate():
	#super() #calling to base func
	can_dash = true

	
	
func s_physics_process(_delta):
	tick += 1 
	if Input.is_action_just_pressed("dash"):
		dashDirection = -1 if owner.anim.flip_h else 1
		doDash = true
		#dash_effect.start()
		
	if doDash:
		owner.velocity.x = dashDirection * physics.max_speed * physics.speed_multiplier
		owner.velocity.y = 0
	elif owner.input_axis: owner.velocity.x = owner.input_axis * physics.max_speed
	else: owner.velocity.x = move_toward(owner.velocity.x,0,physics.max_speed)
	
	if tick >= 50:
		tick = 0
		machine.transition_to(machine.states["IdleState"])
		
	
func s_deactivate():
	pass
