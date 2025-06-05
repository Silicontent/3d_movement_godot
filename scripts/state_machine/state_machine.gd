# code for the State and StateMachine from
# https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/

class_name StateMachine
extends Node

# emitted when transitioning to new state
signal transitioned(state_name)

# contains path to the starting state
@export var initial_state: State = null

# current active state, set to initial_state at the start of the game
@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()


func _ready() -> void:
	# give every state a reference to the state machine
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
	
	# wait for owner and all of its children/data to load before entering
	# initial state
	await owner.ready
	state.enter("")


func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": State transition failed because given state '" + target_state_path + "' does not exist.")
		return
	
	var prev_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(prev_state_path, data)


# STATE VIRTUAL FUNCTION CALLS ================================================
func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)
