extends PlayerState


func physics_update(delta: float) -> void:
	# slow the player down
	player.velocity.x = move_toward(player.velocity.x, 0, delta)
	player.velocity.z = move_toward(player.velocity.z, 0, delta)
	
	# transition to other states
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.get_vector("left", "right", "forward", "backward") != Vector2.ZERO:
		finished.emit(MOVING)
