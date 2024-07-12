extends StateMachine

@export var bossbat : BossBat

func _ready():
	
	for state in get_children():
		states[state.get_name()] = state
		state.machine = self
		state.BossBat = bossbat

	active_state = states["AirState"]
	active_state.s_activate()
