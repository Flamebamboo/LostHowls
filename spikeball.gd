extends AnimatableBody2D
@export var swing = true
@export var CameraRef: Camera2D
	
signal CollidedPlayer
func _ready():
	if swing: $AnimationPlayer.play("swing")
	CollidedPlayer.connect(CameraRef.apply_shake)

	


func _on_shake_body_entered(body):
	print("hello")
	if body.is_in_group("dog"):
		emit_signal("CollidedPlayer")
