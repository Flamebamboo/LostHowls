extends MiniBatState

@export var raycast: RayCast2D
@export var line: Line2D
@onready var dog: Player = Global.dogCharacter
@export var anim: AnimationPlayer
@export var laser_duration: float = 2.0 # How long the laser stays active
var laser_timer: Timer

func s_activate():
	# Play laser animation and sound
	anim.play("laser")
	owner.velocity = Vector2.ZERO
	owner.move_and_slide()
	SoundManager.laser_sound.play()
	raycast.enabled = true
	# Start the laser duration timer
	laser_timer = Timer.new()
	laser_timer.wait_time = laser_duration
	laser_timer.one_shot = true
	add_child(laser_timer)
	laser_timer.start()

func s_physics_process(delta):
	if raycast:
		# Aim raycast at the player's position
		var cast_to = raycast.to_local(dog.global_position)
		raycast.target_position = cast_to
		
		if raycast.is_colliding():
			var cast_point = raycast.to_local(raycast.get_collision_point())
			line.set_point_position(1, cast_point)
			var collider = raycast.get_collider()
			
			if collider is Hurtbox:
				# Apply reduced damage over time instead of instant heavy damage
				collider.apply_laser_damage(1, delta)

	# Deactivate laser when the timer runs out
	if laser_timer.is_stopped():
		anim.play("off")
		machine.transition_to(machine.states["ChaseState"])

func s_deactivate():
	anim.play("off")
	raycast.enabled = false
