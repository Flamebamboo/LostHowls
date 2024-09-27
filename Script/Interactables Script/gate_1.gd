extends Area2D
@onready var gate = $Gate1
var key_collected: bool = false
var gate_is_open: bool  = true #debugging purposes ;/ my brain isnt braining why its not working as expected
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var has_permanently_close: bool = false

func _ready():
	collision_status(false)
	gate_is_open = false
	animation.play("close")
func _on_body_entered(body):
	if body is Player && !key_collected:
		collision_status(false)
		gate_is_open = false
		print("cant open gate")
		animation.play("close")
	elif body is Player && !has_permanently_close:
		collision_status(true)
		gate_is_open = true
		print("open gate")
		animation.play("open")
func collision_status(status: bool):
	for child in gate.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", status)



func _on_keys_key_collected() -> void:
	key_collected = true 
	print("got key")


func _on_body_exited(body: Node2D) -> void:
		if body is Player:
			collision_status(false)
			gate_is_open = false
			animation.play("close")
			has_permanently_close = true
