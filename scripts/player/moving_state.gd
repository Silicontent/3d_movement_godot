extends PlayerState


func physics_update(delta: float) -> void:
	# get input direction and calculate movement direction
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	player.direction = lerp(
		player.direction,
		(player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),
		delta * player.MOMENTUM
	)
	
	player.move()
	
	# transition to other states
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif input_dir == Vector2.ZERO:
		finished.emit(IDLE)
