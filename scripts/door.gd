extends AnimatableBody3D

var target_angle := 0.0


func toggle() -> void:
	#var tween := get_tree().create_tween()
	#if absf(rotation_degrees.y) == 90.0:
		#tween.tween_property(self, "rotation_degrees", Vector3(0.0, 0.0, 0.0), 0.5)
	#else:
		#tween.tween_property(self, "rotation_degrees", Vector3(0.0, 90.0, 0.0), 0.5)
	
	target_angle = 90.0 if target_angle == 0.0 else 0.0


func _physics_process(_delta: float) -> void:
	rotation_degrees.y = lerp(rotation_degrees.y, target_angle, 0.05)
