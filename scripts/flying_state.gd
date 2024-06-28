
extends NodeState

@export var characterBody: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D
var dir: Vector2
var SPEED = 50
@export var flyingtimer: Timer

func enter():
	animatedSprite.play("flying")
	flyingtimer.start()

func on_process():
	characterBody.velocity = dir * SPEED
	characterBody.move_and_slide()
	

	


func _on_timer_timeout():
	$"../../flyingtimer".wait_time = choose([1.0, 1.5, 2])
	dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
		
		
func choose(array):
	array.shuffle()
	return array.front()
		
func exit():
	characterBody.velocity = Vector2.ZERO
	animatedSprite.stop()
