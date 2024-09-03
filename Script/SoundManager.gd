extends Node
#sound manager script
var sound_queuesByName: Dictionary = {}
var sound_poolByName: Dictionary = {}

@export var shoot_sound: AudioStreamPlayer
@export var laser_sound: AudioStreamPlayer
@export var impact_sound: AudioStreamPlayer
@export var charge_sound: AudioStreamPlayer

#func _ready():
	#sound_queuesByName["ShootSoundQueue"] = get_node("ShootSoundQueue")
	#sound_queuesByName["LaserSoundQueue"] = get_node("LaserSoundQueue")
	#sound_queuesByName["ImpactSoundQueue"] = get_node("ImpactSoundQueue")
	#sound_queuesByName["ChargeSoundQueue"] = get_node("ChargeSoundQueue")
	#
#func PlayShootSound():
	#sound_queuesByName["ShootSoundQueue"].play_sound()
#
#func PlayLaserSound():
	#sound_queuesByName["LaserSoundQueue"].play_sound()
#
#func PlayImpactSound():
	#sound_queuesByName["ImpactSoundQueue"].play_sound()
#
#func PlayChargeSound():
	#sound_queuesByName["ChargeSoundQueue"].play_sound()
