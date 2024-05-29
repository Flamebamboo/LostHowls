extends CharacterBody2D

@export var SPEED = 30
var dir: Vector2
var bat_chase: bool
var dog: CharacterBody2D

func _ready():
	bat_chase = true
	
	
	
func _process(delta):
	move(delta)
	handle_animation()

func move(delta):
	if bat_chase:
		dog = Global.dogCharacter
		velocity = position.direction_to(dog.position) * SPEED
		dir.x = abs(velocity.x) / velocity.x
	elif !bat_chase:
		velocity += dir * SPEED * delta 
	move_and_slide()
	
func _on_timer_timeout():
	$Timer.wait_time = choose([1.0, 1.5, 2])
	if !bat_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
		
		
func choose(array):
	array.shuffle()
	return array.front()

func handle_animation():
	var animatedSprite = $AnimatedSprite2D
	animatedSprite.play("flying")
	if dir.x == 1:
		animatedSprite.flip_h = false
		
	if dir.x == -1:
		animatedSprite.flip_h = true
