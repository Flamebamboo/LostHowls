extends AnimatedSprite2D

@export var player = Player.new()


func _on_player_state_machine_state_changed(active_state):
	match active_state.get_name():
		"IdleState":
			play("idle")
		"RunState":
			play("run")
		"AirState":
			play("fall")
		"JumpState":
			play("jump")
		"DeadState":
			play("idle")
		"GlidingState":
			play("glide")
