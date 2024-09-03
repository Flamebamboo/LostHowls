extends StateMachine
var bossbat: BossBat
func _ready():
	
	for state in get_children():
		states[state.get_name()] = state
		state.machine = self
		state.bossbat = bossbat

	active_state = states["SleepState"]
	active_state.s_activate()
	
