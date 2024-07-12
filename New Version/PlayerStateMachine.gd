extends StateMachine

@export var player : Player

func _ready():
	
	for state in get_children():
		states[state.get_name()] = state
		state.machine = self
		state.player = player

	active_state = states["IdleState"]
	active_state.s_activate()
