extends MiniBatState

@onready var navigation_agent_2d: NavigationAgent2D = $"../../NavigationAgent2D"
@onready var velocity_components: VelocityComponents = %VelocityComponents

# Reference the TileMap (make sure the TileMap has a NavigationLayer set up)
@onready var navigation_tilemap = Global.navigation_tile

func s_activate():
	randomize() # Ensure randomization for each instance
	set_random_target() # Set the initial random roaming target

func s_physics_process(_delta):
	if navigation_agent_2d.is_navigation_finished():
		# Pick a new random target if the current path is finished
		set_random_target()
		return
	
	# Move towards the next point in the path
	var next_path_position = navigation_agent_2d.get_next_path_position()
	var direction = owner.global_position.direction_to(next_path_position)
	owner.velocity = direction * velocity_components.max_speed
	var angle = direction.angle()
	$"../../Laser Executer".rotation = angle
	owner.move_and_slide()

# Set a random target position within the bounds of the TileMap
func set_random_target():
	var random_position: Vector2

	while true:
		# Get the boundaries of the used portion of the TileMap
		var map_bounds_min = navigation_tilemap.map_to_local(navigation_tilemap.get_used_rect().position)
		var map_bounds_max = navigation_tilemap.map_to_local(navigation_tilemap.get_used_rect().end)
		
		# Pick random tile coordinates within the TileMap bounds
		var random_tile_x = int(randf_range(navigation_tilemap.get_used_rect().position.x, navigation_tilemap.get_used_rect().end.x))
		var random_tile_y = int(randf_range(navigation_tilemap.get_used_rect().position.y, navigation_tilemap.get_used_rect().end.y))
		
		# Convert tile coordinates to local world coordinates
		random_position = navigation_tilemap.map_to_local(Vector2(random_tile_x, random_tile_y))
		
		# Set the random target position to the NavigationAgent2D
		navigation_agent_2d.target_position = random_position

		# After setting the target, check if a path is valid
		if not navigation_agent_2d.is_navigation_finished():
			# If a valid path was found, break the loop
			break
