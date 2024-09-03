extends Area2D

@export var CameraRef: Camera2D
@export var area_pcam: PhantomCamera2D
@export var shake: bool = false
var should_shake: bool = false

# Called when a body enters the area
func _on_body_entered(body):
	# Check if the entering body is in the "player" group
	if body.is_in_group("player"):
		# Set the priority of the Phantom Camera
		area_pcam.set_priority(20)
		
	
	# Check if shaking is enabled
	if shake:
		should_shake = true
		# Apply a shake effect to the CameraRef
		CameraRef.apply_shake(20.0, 10.0)

# Called when a body exits the area
func _on_body_exited(body):
	# Check if the exiting body is in the "player" group
	if body.is_in_group("player"):
		# Reset the priority of the Phantom Camera
		area_pcam.set_priority(0)
