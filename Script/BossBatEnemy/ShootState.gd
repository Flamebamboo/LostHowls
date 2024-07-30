extends BossBatState
 #SHOOTSTATE

@export var animatedSprite: AnimatedSprite2D
@export var animation: AnimationPlayer

@export var spawn_point_count: int = 8
const radius: int = 100
@onready var rotater := %Rotater
@onready var shoottimer := %shoottimer
var batbullet = preload("res://Scenes/bat_bullet.tscn")

var dog: Player

func s_activate():
	dog = Global.dogCharacter
	animation.play("attack")
	animatedSprite.play("attack")
	#2*pi is 360 deg divided by 8 so each spawnpoint is 45deg apart
	var step = 2 * PI / spawn_point_count
	
	for child in rotater.get_children():
		rotater.remove_child(child)
		child.queue_free() # got help from chatgpt to debug my code this chunk got rid of multiple damage per hit
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.rotation = pos.angle()
		spawn_point.position = pos
		rotater.add_child(spawn_point) # spawn_point will add as rotater child so it will follow along with the rotatation of the rotator
	
	
	for s in rotater.get_children():
		var bullet = batbullet.instantiate()
		get_tree().root.call_deferred("add_child", bullet)
		bullet.global_position = s.global_position
		bullet.rotation = s.global_rotation
	
	await get_tree().create_timer(1).timeout
	machine.transition_to(machine.states["FlyingState"])
	

	
	
