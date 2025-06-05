extends PlayerState


func enter(prev_state_path: String, data := {}) -> void:
	player.velocity = Vector3.ZERO
	player.direction = Vector3.ZERO


func physics_update(delta: float) -> void:
	# until the player hits the ground, they cannot move
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	# transition to other states
	if player.is_on_floor():
		finished.emit(IDLE)
