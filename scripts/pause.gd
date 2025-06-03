extends Control


func _on_resume_button_pressed() -> void:
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()
