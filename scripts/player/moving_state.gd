extends PlayerState


func physics_update(delta: float) -> void:
	# get input direction and calculate movement direction
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	player.direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# handle movement
	player.velocity.x = player.direction.x * player.current_speed
	player.velocity.z = player.direction.z * player.current_speed
	
	player.move_and_slide()
	
	# transition to other states
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif input_dir == Vector2.ZERO:
		finished.emit(IDLE)
