extends Camera2D

@export var default_random_strength: float = 100.0
@export var default_shake_fade: float = 5.0

@onready var shake_active: bool = false
var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0
var shake_fade: float = 0.0

# This function will be called with different shake parameters

	
func apply_shake(strength: float, fade: float):
	shake_active = true
	shake_strength = strength
	shake_fade = fade

func _process(delta):
	if shake_active:
		if shake_strength > 0:
			shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
			offset = random_offset()
		else:
			shake_active = false
			offset = Vector2.ZERO  # Reset offset when shake is done

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
