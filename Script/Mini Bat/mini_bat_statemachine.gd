extends StateMachine
var mini_bat: MiniBat

func _ready():
	for state in get_children():
		states[state.get_name()] = state
		state.machine = self
		state.mini_bat = mini_bat
	active_state = states["Wandering State"]
	active_state.s_activate()
