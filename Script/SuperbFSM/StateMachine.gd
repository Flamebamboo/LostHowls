extends Node
class_name StateMachine


var states := {}
var active_state: BaseState
var previous_active_state: BaseState

signal state_changed

func _ready():
	for state in get_children():
		states[state.name.to_lower()] = state
		state.machine = self

func transition_to(state: BaseState):
	print (str("State switch: ", active_state.get_name(), " to ", state.get_name()))
	active_state.s_deactivate()
	previous_active_state = active_state
	active_state = state
	active_state.s_activate()
	state_changed.emit(active_state, previous_active_state)
	
func _process(delta):
	active_state.s_process(delta) #ensuring that child states that uses s_process runs every frame

	
func _physics_process(delta):
	active_state.s_physics_process(delta)
