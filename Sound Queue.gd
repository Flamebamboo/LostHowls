@tool
extends Node
class_name SoundQueue

var next = 0
var audioStreamPlayers = []

@export var Count: int = 1

func _ready():
	if get_child_count() == 0:
		print("No AudioStreamPlayer child found.")
		return

	var child = get_child(0)
	if child is AudioStreamPlayer:
		audioStreamPlayers.append(child)

		for i in range(Count):
			var duplicate = child.duplicate()
			add_child(duplicate)
			audioStreamPlayers.append(duplicate)

func play_sound():
	if audioStreamPlayers[next].is_playing() == false:
		audioStreamPlayers[next].play()
		next = (next + 1) % audioStreamPlayers.size()

func _get_configuration_warnings():
	var warnings = []
	if get_child_count() == 0:
		warnings.append("No children found. Expected one AudioStreamPlayer child.")
	elif not (get_child(0) is AudioStreamPlayer):
		warnings.append("Expected first child to be an AudioStreamPlayer.")
	return warnings

	
	
	
