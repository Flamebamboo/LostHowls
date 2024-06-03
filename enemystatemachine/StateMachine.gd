
extends Node
class_name NodeFiniteStateMachine
@export var initial_node_state: NodeState

var node_states: Dictionary = {}
var current_node_state: NodeState
var current_node_state_name: String

func _ready():
	for child in get_children():
		if child is NodeState:
			node_states[child.name.to_lower()] = child

	if initial_node_state:
		current_node_state = initial_node_state
		current_node_state.enter()

func _process(_delta):
	if current_node_state:
		current_node_state.on_process()

func _physics_process(_delta):
	if current_node_state:
		current_node_state.on_physics_process()
	print("Current State: ", current_node_state.name.to_lower())
func transition_to(node_state_name: String):
	if node_state_name == current_node_state_name:
		return

	var new_node_state = node_states.get(node_state_name.to_lower())
	if !new_node_state:
		return

	if current_node_state:
		current_node_state.exit()

	new_node_state.enter()
	current_node_state = new_node_state
	current_node_state_name = current_node_state.name.to_lower()
