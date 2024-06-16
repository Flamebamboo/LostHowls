class_name Playerlauncher
extends CharacterBody2D
var travelled_distance = 0.0
@export var areabox : Areabox

@export var speed: int =  500
@export var range: int = 300

##
func _ready():
	if areabox:
		#hurtbox.hitdog.connect(on_dog_hit)
		pass

func _physics_process(delta: float) -> void:
	position += velocity * delta
	travelled_distance += velocity.length() * delta
	if travelled_distance > range: 
		queue_free()


func on_dog_hit():
	#launching player  knockback logic here
	pass
