extends Area2D
@onready var gate = $Gate
var boss_defeated: bool = false
var gate_is_open: bool  = true #debugging purposes ;/ my brain isnt braining why its not working as expected

#COMMON SENSE
	# if dog in cave area the gate will be closed if the dog is outside the gate will be open again 
	# However to make it open again after the boss is defeated i need to disable the enter and exit func or else its gonna be crazy 
		
func _ready():
	collision_disabled(true)
	$Gate/AnimatedSprite2D2.play("open")
	gate_is_open = true
	
func _process(delta):
	print(gate_is_open)
func _on_body_entered(body):
	if body is Player && !boss_defeated:
		collision_disabled(false)
		$Gate/AnimatedSprite2D2.play("close")
		gate_is_open = false

func collision_disabled(disabled: bool):
	for child in gate.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", disabled)


func _on_body_exited(body):
	if body is Player && !boss_defeated:
		collision_disabled(true)
		$Gate/AnimatedSprite2D2.play("open")
		gate_is_open = true

func _on_boss_bat_boss_bat_death():
	collision_disabled(true)
	$Gate/AnimatedSprite2D2.play("open")
	gate_is_open = true
	boss_defeated = true
