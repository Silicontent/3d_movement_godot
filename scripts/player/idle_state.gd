extends PlayerState


func physics_update(delta: float) -> void:
	# slow player to a stop
	player.direction = lerp(
		player.direction,
		Vector3.ZERO,
		delta * player.MOMENTUM
	)
	
	player.move()
	
	# transition to other states
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.get_vector("left", "right", "forward", "backward") != Vector2.ZERO:
		finished.emit(MOVING)
