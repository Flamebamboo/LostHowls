extends AnimatableBody2D

var current_pos: Vector2
var amplitude: float = 100.0
var move_speed: float = 2.0

var last_position: Vector2
@onready var pressure_plate: AnimatedSprite2D = $"../PressurePlates/PressurePlate"
@onready var activation_platform: AnimatedSprite2D = $ActivationPlatform

var rock_on_plate: bool = false
var time_passed: float = 0.0

func _ready():
	current_pos = position
	last_position = current_pos
	activation_platform.play("NotActive")
	
func _physics_process(delta: float) -> void:
	if rock_on_plate == true:
		time_passed += delta * move_speed
		# Calculate the new Y position with smooth up and down movement
		position.y = current_pos.y + sin(time_passed) * amplitude #chatgpt help 

		last_position = position
	else:
		position = last_position


func _on_pressure_plates_body_entered(body: Node2D) -> void:
	if body is MovableRock:
		rock_on_plate = true
		pressure_plate.play("Pressed")
		activation_platform.play("Active")

func _on_pressure_plates_body_exited(body: Node2D) -> void:
	if body is MovableRock:
		rock_on_plate = false
		pressure_plate.play("NotPressed")
		activation_platform.play("NotActive")
