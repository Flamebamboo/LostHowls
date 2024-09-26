extends Area2D

@export var activation_platform: AnimatableBody2D
@onready var pressure_plate: AnimatedSprite2D = $PressurePlate

func _on_body_entered(body: Node2D) -> void:
	if body is MovableRock:
		activation_platform._activated_plate()
		pressure_plate.play("Pressed")
		
func _on_body_exited(body: Node2D) -> void:
	if body is MovableRock:
		pressure_plate.play("NotPressed")
		activation_platform._deactivated_plate()
