extends Area2D

@export var radio_tape: AudioStreamPlayer2D	
@onready var label = $Radiotape/Label

var player_in_area: bool

signal SubtitlesUI
func _physics_process(_delta):
	if player_in_area:
		if Input.is_action_just_pressed("interact"):
			label.hide()
			radio_tape.play()
			emit_signal("SubtitlesUI")
			

func _ready() -> void:
	connect("area_entered", _entered_area)
	connect("area_exited", _exited_area)
	label.hide()
	
func _entered_area(area_2d: Area2D) -> void:
	player_in_area = true
	if area_2d.get_parent() is CharacterBody2D:
		label.show()
	
		
func _exited_area(area_2d: Area2D) -> void:
	player_in_area = false
	if area_2d.get_parent() is CharacterBody2D:
		label.hide()
		
