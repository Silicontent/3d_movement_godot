extends CanvasLayer

@onready var pause_menu := $Pause


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		pause_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
