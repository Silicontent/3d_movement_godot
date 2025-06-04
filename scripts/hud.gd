extends CanvasLayer

@export var player: Player

@onready var pause_menu := $Pause
@onready var interact_circle := $Overlay/InteractCircle


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		pause_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
	
	# DEBUG: show a circle around the reticle if the player is looking at
	# and can reach an object
	interact_circle.visible = player.reach_ray.is_colliding()
