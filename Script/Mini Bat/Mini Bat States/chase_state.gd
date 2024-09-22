extends MiniBatState
@onready var navigation_agent_2d: NavigationAgent2D = $"../../NavigationAgent2D"
@onready var velocity_components: VelocityComponents = %VelocityComponents

var target: CharacterBody2D

func s_activate():
	target = Global.dogCharacter
	if target:
		navigation_agent_2d.target_position = target.global_position
		
func s_physics_process(_delta):
	
	if target:
		navigation_agent_2d.target_position = target.global_position
		
	if navigation_agent_2d.is_navigation_finished():
		return #logic to switch to closeup attack state
	
	var current_pos = owner.global_position
	var next_path = navigation_agent_2d.get_next_path_position()
	
	var direction = current_pos.direction_to(next_path) 
	var new_velocity = direction * velocity_components.max_speed
	var angle = direction.angle()
	$"../../Laser Executer".rotation = angle
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
		
	owner.move_and_slide()
	

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	owner.velocity = safe_velocity
