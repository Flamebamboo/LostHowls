@tool
extends Node
class_name SoundPool
var sound := []
var rng:= RandomNumberGenerator.new()
var last_index := -1

func _ready():
	for child in get_children():
		if child is SoundQueue:
			sound.append(child)
			

func _get_configuration_warnings():
	var warnings = []
	if get_child_count() < 2:
		warnings.append("Expected more than 2 children sounds")
	elif not (get_child(0) is SoundQueue):
		warnings.append("Expected for SoundQueue Node.")
	return warnings

func PlayRandomSound():
	var index: int
	
	if sound.size() <= 0:
		print("no sound attached")
		return #exits if there is not sound
		
	while true: #sound size returns how many sound there is in the list
		index = rng.randi_range(0, sound.size() - 1) #random.randi_range(min, max), it returns a random integer between min and max, inclusive.
		if index != last_index:
			break
	last_index = index
	sound[index].play_sound()
