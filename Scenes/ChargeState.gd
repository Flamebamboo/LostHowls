extends BossBatState
var dog: Player
@export var animator: AnimatedSprite2D
@export var animation: AnimationPlayer
#signal ChargeDamage #to be sent to hurtbox and emit when collide with player during this state
@export var velocity_component: VelocityComponents

var is_charging: bool = false

@export var raycast: RayCast2D

func s_activate():
	dog = Global.dogCharacter
	animation.play("attack")
	animator.play("attack")
	is_charging = true
	
func s_physics_process(delta):
	if is_charging:
		raycast.target_position = raycast.to_local(dog.global_position)
		if raycast.is_colliding():
			if raycast.get_collider() is Player:
				owner.velocity = owner.velocity.move_toward(raycast.target_position * velocity_component.charge_speed, velocity_component.charge_acceleration * delta)
				animator.scale.x = -sign(bossbat.velocity.x)
				if animator.scale.x == 0: animator.scale.x = 1
		await get_tree().create_timer(1.5).timeout
		machine.transition_to(machine.states["FlyingState"])	
	
