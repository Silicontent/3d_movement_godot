extends Area3D


# reset any objects that fall back to the top of the map
func _on_body_entered(body: Node3D) -> void:
	body.global_position = Vector3(0, 5, 0)
