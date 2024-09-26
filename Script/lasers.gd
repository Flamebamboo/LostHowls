extends RayCast2D

@export var laser_active_duration: float = 0.5  # Time the laser stays visible (in seconds)
@export var laser_inactive_duration: float = 1.0  # Time the laser stays invisible (in seconds)

@onready var timer: Timer = $Timer
@onready var line_2d: Line2D = $LaserLine

const laser_damage: float = 2.0
var laser_active: bool = false
var tween: Tween = null

func _physics_process(delta: float) -> void:
	var collider = get_collider()
	if collider is Hurtbox and laser_active:
		collider.apply_laser_damage(laser_damage, delta)
	
	var cast_point := target_position
	force_raycast_update()
	if is_colliding():
		cast_point = to_local(get_collision_point())
	line_2d.points[1] = cast_point

func _ready():
	timer.wait_time = laser_inactive_duration
	self.enabled = false
	timer.start()

func _on_timer_timeout() -> void:
	laser_active = !laser_active

	if laser_active:
		self.enabled = true
		timer.wait_time = laser_active_duration
		activate_laser()
	else:
		timer.wait_time = laser_inactive_duration
		deactivate_laser()

	timer.start()

func activate_laser():
	# Create a new tween for smooth activation
	tween = create_tween()
	tween.tween_property(line_2d, "modulate:a", 1.0, 0.3)

func deactivate_laser():
	# Create a new tween for smooth deactivation
	tween = create_tween()
	tween.tween_property(line_2d, "modulate:a", 0.0, 0.3)
	
	# Delay disabling the laser until the fade-out is complete
	tween.finished.connect(_on_tween_completed)

func _on_tween_completed():
	self.enabled = false
