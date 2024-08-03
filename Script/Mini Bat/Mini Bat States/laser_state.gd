extends MiniBatState

@export var raycast: RayCast2D
@export var line: Line2D
@onready var dog: Player = Global.dogCharacter
@export var anim: AnimationPlayer



func s_activate():
	anim.play("laser")
	owner.velocity = Vector2.ZERO
	owner.move_and_slide()
	
func s_deactivate():
	anim.play("off")


func s_physics_process(_delta):
	if raycast:
		var cast_to = raycast.to_local(dog.global_position)
		raycast.target_position = cast_to
		if raycast.is_colliding():
			var cast_point = raycast.to_local(raycast.get_collision_point())
			line.set_point_position(1, cast_point)

		
