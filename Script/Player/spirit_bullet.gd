
extends CharacterBody2D

var travelled_distance: float = 0.0
@export var speed: int =  600

var direction = Vector2(0,0)
var max_distance : float = 5000.0
func _ready():
	add_to_group("bullet")
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - self.global_position).normalized()
	#max_distance = global_position.distance_to(mouse_position)
func _physics_process(delta):
	var velocity = direction * speed * delta
	var collision := move_and_collide(velocity)
	if collision:
		queue_free()
		return
	travelled_distance += velocity.length()
	if travelled_distance >= max_distance:
		queue_free()


