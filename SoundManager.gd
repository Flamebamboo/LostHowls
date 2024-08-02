extends Node
#sound manager script
var sound_queuesByName: Dictionary = {}
var sound_poolByName: Dictionary = {}

#func _ready():
	#sound_queuesByName["LaserSoundQueue"] = get_node("LaserSoundQueue")
	#
#
#func _process(delta):
	#pass
#
#func PlayFireballSound():
	#if sound_queuesByName.has("LaserSoundQueue"):
		#sound_queuesByName["LaserSoundQueue"].play()
