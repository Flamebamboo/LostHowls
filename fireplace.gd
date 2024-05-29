extends Node
@onready var anim = self

func _ready():
	anim.play("nofire")
func _on_area_2d_body_entered(body):
	if body.is_in_group("dog") and Input.is_action_just_pressed("interact"):
		anim.play("fire")
