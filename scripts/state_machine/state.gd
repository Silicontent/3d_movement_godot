class_name State
extends Node

signal finished(next_state_path: String, data: Dictionary)


# receives info from the _unhandled_input() function
func handle_input(_event: InputEvent) -> void:
	pass


# corresponds to _process()
func update(_delta: float) -> void:
	pass


# corresponds to _physics_process()
func physics_update(_delta: float) -> void:
	pass


# called by StateMachine when changing active state
# "data" is a dictionary that holds any arbitrary data the state can use to
# initialize itself
func enter(prev_state_path: String, data := {}) -> void:
	pass


# called by StateMachine before changing active state
func exit() -> void:
	pass
