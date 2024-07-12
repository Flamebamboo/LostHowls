extends AnimatableBody2D
@export var swing = true
@export var CameraRef: Camera2D
	

func _ready():
	if swing: $AnimationPlayer.play("swing")

	


func _on_shake_body_entered(body):
	if body.is_in_group("dog"):
		CameraRef.apply_shake(20.0, 10.0)
