extends BossBatState
var dog: Player
@export var animator: AnimatedSprite2D
@export var animation: AnimationPlayer
signal ChargeDamage #to be sent to hurtbox and emit when collide with player during this state
@export var velocity_component: VelocityComponents
func s_activate():
	dog = Global.dogCharacter
	
	
func s_physics_process(delta):
	var direction = bossbat.global_position.direction_to(dog.global_position)
	bossbat.velocity = bossbat.velocity.move_toward(direction * velocity_component.max_speed, velocity_component.acceleration * delta)
	animator.scale.x = -sign(bossbat.velocity.x)
	if animator.scale.x == 0: animator.scale.x = 1
	var collided_player = bossbat.move_and_collide(bossbat.velocity * delta)
	if collided_player:
		var knockbackDir = bossbat.position.direction_to(dog.position) * -velocity_component.knockback
		bossbat.velocity = knockbackDir
