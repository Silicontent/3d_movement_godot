extends PlayerState


func physics_update(delta: float) -> void:
	# slow player to a stop
	# TODO: check that this actually does anything
	player.velocity.x = move_toward(player.velocity.x, 0, player.current_speed)
	player.velocity.z = move_toward(player.velocity.z, 0, player.current_speed)
	player.move_and_slide()
	
	# transition to other states
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.get_vector("left", "right", "forward", "backward") != Vector2.ZERO:
		finished.emit(MOVING)
