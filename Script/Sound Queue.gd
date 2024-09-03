@tool
extends Node
class_name SoundQueue

var next = 0
var audioStreamPlayers = []

@export var Count: int = 1

func _ready():
	if get_child_count() == 0: #checking if there is a child 
		print("No audio child found.")
		return

	var child = get_child(0) #check the first index 
	if child is AudioStreamPlayer:
		audioStreamPlayers.append(child) #we add into the audioStreamPlayers if the child is audio

		for i in range(Count):  #looping through where counts is a variable to duplicate how much
			var duplicating = child.duplicate()
			add_child(duplicating)
			audioStreamPlayers.append(duplicating)

func play_sound():
	if audioStreamPlayers[next].is_playing() == false:
		audioStreamPlayers[next].play()
		next = (next + 1) % audioStreamPlayers.size() #chatgpt tysmm 

#ADDITIONAL WARNING CHECKS SINCE I USED @TOOL
func _get_configuration_warnings():
	var warnings = []
	if get_child_count() == 0:
		warnings.append("No children found. Expected one AudioStreamPlayer child.")
	elif not (get_child(0) is AudioStreamPlayer):
		warnings.append("Expected first child to be an AudioStreamPlayer.")
	return warnings

#chatgpt code line 27 the purpose,
	#(next + 1) % audioStreamPlayers.size():
	#The modulo operator % calculates the remainder of the division of (next + 1) by the size of the audioStreamPlayers array.
	#This ensures that if next reaches the end of the array, it wraps around to 0. For example, if there are 3 AudioStreamPlayer nodes, and next is 2 (the last index), next + 1 would be 3, and 3 % 3 is 0, so next wraps around to 0.
	#next = (next + 1) % audioStreamPlayers.size(): Updates the next variable to point to the next AudioStreamPlayer in the array, ensuring it wraps around if it reaches the end.
