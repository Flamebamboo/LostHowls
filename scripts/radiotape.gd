extends Area2D

@export var radio_tape: AudioStreamPlayer2D	
var player_in_area: bool

func _physics_process(_delta):
	if player_in_area:
		if Input.is_action_just_pressed("interact"):
			$"../Label".hide()
			radio_tape.play()

func _ready() -> void:
	connect("area_entered", _entered_area)
	connect("area_exited", _exited_area)
	$"../Label".hide()
	
func _entered_area(area_2d: Area2D) -> void:
	player_in_area = true
	if area_2d.get_parent() is CharacterBody2D:
		$"../Label".show()
	
		
func _exited_area(area_2d: Area2D) -> void:
	player_in_area = false
	if area_2d.get_parent() is CharacterBody2D:
		$"../Label".hide()
		
