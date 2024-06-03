#extends Area2D
#
#@export var SPEED = 200
#@export var DAMAGE = 10
#var direction = Vector2.ZERO
#
#func _ready():
	#$AnimatedSprite2D.play("fire")
#
#func _process(delta):
	#position += direction * SPEED * delta
	#var viewport_rect = get_viewport_rect()
	#var projectile_rect = Rect2(position, Vector2(10, 10)) # Adjust the size of the projectile if necessary
	#if not viewport_rect.encloses(projectile_rect):
		#queue_free()
#
#
#func _on_body_entered(body):
	#if body.is_in_group("dog"): # Assuming your player is in a group called "Player"
		#body.take_damage(DAMAGE)
		#queue_free()
