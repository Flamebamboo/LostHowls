extends NodeState

@export var characterBody : CharacterBody2D
@export var animatedSprite : AnimatedSprite2D
@export var speed : int


var dog : CharacterBody2D

func on_process(delta : float):
	pass



func _physics_process(delta : float):
	var direction : int
	if dog:
		if characterBody.global_position > dog.global_position:
			animatedSprite.flip_h = false
			direction = -1	
		elif characterBody.global_position < dog.global_position:
			animatedSprite.flip_h = true
			direction = 1
		
		animatedSprite.play("attack")
	
	characterBody.velocity.x += direction * speed * delta
	characterBody.velocity.x = clampf(characterBody.velocity.x, -speed, speed)
	characterBody.move_and_slide()
	
func enter():
	pass
	dog = get_tree().get_nodes_in_group("dog")[0] as CharacterBody2D

func exit():
	pass
	

