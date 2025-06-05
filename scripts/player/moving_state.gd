extends PlayerState


func physics_update(delta: float) -> void:
	player.move(delta)
	
	# transition to other states
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.get_vector("left", "right", "forward", "backward") == Vector2.ZERO:
		finished.emit(IDLE)
