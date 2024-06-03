extends CharacterBody2D
class_name BatEnemy
@export var SPEED = 30
var dir: Vector2
var batChase: bool
var dog: CharacterBody2D
var health = 50
var healthMax = 50
var healthMin = 0
var dead = false
var takingDamage = false
var isRoaming: bool
var DamagetoDeal = 20
func _ready():
	batChase = true
	
	
func _process(delta):
	Global.batDamageAmount = DamagetoDeal
	Global.batDamageZone = $DealDamageArea
	if is_on_floor() and dead:
		await get_tree().create_timer(3.0).timeout
		self.queue_free()
	move(delta)
	handle_animation()
	if Global.dogAlive:
		batChase = true
		
	elif !Global.dogAlive:
		batChase = false
#bat logic
func move(delta):
	dog = Global.dogCharacter
	if !dead:
		isRoaming = true
		if !takingDamage and batChase and Global.dogAlive: 
			dog = Global.dogCharacter
			velocity = position.direction_to(dog.position) * SPEED
			dir.x = abs(velocity.x) / velocity.x
		elif takingDamage:
			var knockbackDir = position.direction_to(dog.position) * -500
			velocity = knockbackDir
			
			
		else: #if not chase then roam
			velocity += dir * SPEED * delta 
	elif dead: #fall
		velocity.y += 10 * delta
		velocity.x = 0
	move_and_slide()
	
func _on_timer_timeout():
	$Timer.wait_time = choose([1.0, 1.5, 2])
	if !batChase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
		
		
func choose(array):
	array.shuffle()
	return array.front()

func handle_animation():
	var animatedSprite = $AnimatedSprite2D
	if !dead and !takingDamage:
		animatedSprite.play("flying")
		if dir.x == 1:
			animatedSprite.flip_h = false
		
		if dir.x == -1:
			animatedSprite.flip_h = true
	elif !dead and takingDamage:
		animatedSprite.play("hurt")
		await get_tree().create_timer(0.8).timeout
		takingDamage = false
	elif dead and isRoaming:
		isRoaming = false
		animatedSprite.play("death")
	
	



	


func _on_bat_hitbox_area_entered(area):
	if area == Global.dogDamageZone:
		var damage = Global.dogDamageAmount
		takeDamage(damage)

func takeDamage(damage):
	health -= damage
	takingDamage = true
	if health <= 0:
		health = 0 
		dead = true
	print(str(self), "current health is ", health)


