extends StaticBody2D


@onready var timer: Timer = $Timer
@onready var restore: Timer = $Restore

var is_destroyed: bool = false
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var area: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var playanim: AnimationPlayer = $Sprite2D/AnimationPlayer

func _ready() -> void:
	collision.disabled = false
	sprite.visible = true
	
func destroy_platform():
	if !is_destroyed:
		#play animation
		#await till finish 
	
		playanim.play("destroy")
		await playanim.animation_finished
		collision.disabled = true
		is_destroyed = true
		restore.start()
		
		
	
func restore_platform():
	if is_destroyed:
		#fade animation
		playanim.play("restore")
		await playanim.animation_finished
		sprite.visible = true
		collision.disabled = false 
		is_destroyed = false
		


func _on_timer_timeout() -> void:
	destroy_platform()
	timer.stop()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		timer.start()


func _on_restore_timeout() -> void:
	restore_platform()
	restore.stop()
