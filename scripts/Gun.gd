extends Area2D
const BULLET = preload("res://bullet.tscn")
@export var shooting: Marker2D
var dog: CharacterBody2D
func shoot(): 
	if shooting:
		dog = Global.dogCharacter
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = shooting.global_position
		new_bullet.global_rotation = shooting.global_rotation
		shooting.add_child.call_deferred(new_bullet)



func _on_body_entered(body):
	if body.is_in_group("dog"):
		shoot()
		print("overlapped")


