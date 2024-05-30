extends Area2D
@export var CameraRef: Camera2D
@export var area_pcam: PhantomCamera2D
@export var shake: bool = false
var should_shake: bool = false
func _ready() -> void:
	connect("area_entered", _entered_area)
	connect("area_exited", _exited_area)
	

func _entered_area(area_2d: Area2D) -> void:
	if area_2d.get_parent() is CharacterBody2D:
		area_pcam.set_priority(20)
		print("priority set 20")
	if shake:
		should_shake = true
		
		
func _exited_area(area_2d: Area2D) -> void:
	if area_2d.get_parent() is CharacterBody2D:
		area_pcam.set_priority(0)
	if should_shake:
		should_shake = false
