extends StaticBody2D

var collision_shape1: CollisionShape2D
var collision_shape2: CollisionShape2D
@export var anim1: AnimatedSprite2D
@export var anim2: AnimatedSprite2D
func _ready():
	collision_shape1 = $CollisionShape2D
	collision_shape2 = $CollisionShape2D2
	collision_shape1.disabled = true
	collision_shape2.disabled = true
	anim1.visible = false
	anim2.visible = false

func deactivate_platform():
	collision_shape1.call_deferred("set", "disabled", true)
	collision_shape2.call_deferred("set", "disabled", true)
	anim1.visible = false
	anim2.visible = false
func activate_platform():
	collision_shape1.call_deferred("set", "disabled", false)
	collision_shape2.call_deferred("set", "disabled", false)
	anim1.visible = true
	anim2.visible = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("boxes"): 
		activate_platform()


func _on_area_2d_body_exited(body):
	if body.is_in_group("boxes"):
		deactivate_platform()
	
