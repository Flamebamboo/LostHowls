extends Camera2D
@export var randomStrength: float = 500.0
@export var shakeFade: float = 5.0
#@export var fallenShake: float = 100.0
#@export var fallenFade: float = 4.0
@onready var Shake: bool = false
var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0
#var fallen_strength: float = 0.0
#
#func apply_shake_fallen():
	#fallen_strength = fallenShake 	
#
func apply_shake():
	shake_strength = randomStrength

func _process (delta):
	#normal shake
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta) 
		
		offset = randomOffset()
	#shake for falle refering to area 2d located at the hole	
	#if fallenShake > 0:
		#fallenShake = lerpf(fallenShake,0,fallenFade * delta) 
		#offset = randomOffset2()
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength, shake_strength))
##
#func randomOffset2() -> Vector2:
	#return Vector2(rng.randf_range(-fallenShake,fallenShake),rng.randf_range(-fallenShake, fallenShake))
