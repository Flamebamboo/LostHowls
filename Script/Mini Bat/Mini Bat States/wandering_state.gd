extends MiniBatState

var dir: Vector2
var SPEED = 50
@export var flyingtimer: Timer

func s_activate():
	pass

func s_physics_process(_delta):
	pass
	

	

func _on_flyingtimer_timeout():
	flyingtimer.wait_time = choose([1.0, 1.5, 2])
	change_direction()
	
func change_direction():
	# Avoid choosing the same direction consecutively
	var new_dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
	if new_dir != -dir:  # Prevent immediate reversal
		dir = new_dir.normalized()
	else:
		change_direction()
		
func choose(array):
	array.shuffle()
	return array.front()
		
func s_deactivate():
	owner.velocity = Vector2.ZERO



