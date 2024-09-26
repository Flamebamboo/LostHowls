extends PlayerState
@onready var vfx: GPUParticles2D = $"../../DashVfx"

var tick: float = 0.0
var dash_cooldown: float = 1.0
var dash_check: bool = true

func s_activate():
	if can_dash:
		super()
		dash_check = false
		tick = 0.0
		physics.dash()
		if owner.anim.flip_h == true:
			vfx.scale.x = -1
			vfx.emitting = true
		elif owner.anim.flip_h == false:
			vfx.scale.x = 1
			vfx.emitting = true
		
func s_physics_process(_delta):
	
		
	if !dash_check:
		tick += _delta
		if tick >= dash_cooldown:
			dash_check = true
			tick = 0.0

	tick += 0.15
	if tick >= 0.2:
		tick = 0.0
		physics.ground_decel()
		machine.transition_to(machine.states["IdleState"])

func s_deactivate():
	pass
