extends Area2D
@export var radio_tape: AudioStreamPlayer2D

func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
			$"../Label".hide()
			%AudioStreamPlayer2D.play()

	
func _ready() -> void:
	connect("area_entered", _entered_areas)
	connect("area_exited", _exited_areas)
	$"../Label".hide()
	print(radio_tape)
	
func _entered_areas(area_2d: Area2D) -> void:
	if area_2d.get_parent() is CharacterBody2D:
		$"../Label".show()
	
func _exited_areas(area_2d: Area2D) -> void:
	if area_2d.get_parent() is CharacterBody2D:
		$"../Label".hide()
