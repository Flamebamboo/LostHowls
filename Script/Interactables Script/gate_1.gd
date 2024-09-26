extends Area2D
@onready var gate = $Gate1
var key_collected: bool = false
var gate_is_open: bool  = true #debugging purposes ;/ my brain isnt braining why its not working as expected

#COMMON SENSE
	# if dog in cave area the gate will be closed if the dog is outside the gate will be open again 
	# However to make it open again after the boss is defeated i need to disable the enter and exit func or else its gonna be crazy 
		
func _ready():
	collision_status(false)
	gate_is_open = false
	
func _on_body_entered(body):
	if body is Player && !key_collected:
		collision_status(false)
		gate_is_open = false
	else:
		collision_status(true)
		gate_is_open = true

func collision_status(status: bool):
	for child in gate.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", status)


func _on_keys_key_collected() -> void:
	key_collected = true 
