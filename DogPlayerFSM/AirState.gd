extends PlayerState
@onready var jump_vfx = preload("res://art/VFX/jump_vfx.tscn")
@onready var landing_effect = preload("res://landing_effect.tscn")

	
func s_physics_process(_delta):
	var direction = Input.get_axis("moveleft", "moveright")
	
	physics.apply_gravity()
	if physics.can_jump() and Input.is_action_just_pressed("moveup"):
		physics.jumps()
	
	physics.vertical_air_resistance(_delta)
	physics.horizontal_air_strafe(_delta)	
	
	if owner.is_on_floor(): # IDLE CONDITION
		machine.transition_to(machine.states["IdleState"])
		return


func s_deactivate():
	#jump_effects() # this one doesnt work when i try to instance 
	landeffect() #this one works if i create a instance like normally
#func jump_effects():
	#if jump_vfx:
		#var jump_instance = jump_vfx.instantiate()
		#if physics.velocity.x == 0:
			#jump_instance.current_animation = "double"
			#print("i am called but i dont work")
		#else:
			#jump_instance.current_animation = "landing"
			#print("i am called but i dont work too")
		#
		#jump_instance.global_position = %landeffect.global_position
		#print("position", jump_instance.global_position)
		#get_tree().root.add_child(jump_instance)

func landeffect():
	if landing_effect:
		var landing_instance = landing_effect.instantiate()
		landing_instance.global_position = %landeffect.global_position
		get_tree().root.add_child(landing_instance)
		
		
		
