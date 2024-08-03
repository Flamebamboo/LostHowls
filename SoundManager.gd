extends Node
#sound manager script
var sound_queuesByName: Dictionary = {}
var sound_poolByName: Dictionary = {}

func _ready():
	$Main.play()
	sound_queuesByName["ShootSoundQueue"] = get_node("ShootSoundQueue")
	sound_queuesByName["LaserSoundQueue"] = get_node("LaserSoundQueue")
	sound_queuesByName["ImpactSoundQueue"] = get_node("ImpactSoundQueue")
	
func PlayShootSound():
	sound_queuesByName["ShootSoundQueue"].play_sound()

func PlayLaserSound():
	sound_queuesByName["LaserSoundQueue"].play_sound()

func PlayImpactSound():
	sound_queuesByName["ImpactSoundQueue"].play_sound()
