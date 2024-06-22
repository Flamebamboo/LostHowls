extends Node2D
@export var rotate_speed = 0
@export var shooter_timer_wait_time = 2
@export var spawn_point_count = 5
const radius = 100
@onready var rotater = $Rotater
@onready var shoottimer = $shoottimer
var batbullet = preload("res://batbullet.tscn")
func _ready():
	var step = 2 * PI / spawn_point_count
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.rotation = pos.angle()
		spawn_point.position = pos
		rotater.add_child(spawn_point)

	shoottimer.wait_time = shooter_timer_wait_time
	shoottimer.start()
func _process(delta: float):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)
	
func _on_shoottimer_timeout():
	for s in rotater.get_children():
		var bullet = batbullet.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
