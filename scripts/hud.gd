extends CanvasLayer

# used to get information about what the player is looking at
@export var player: Player

@onready var pause_menu := $Pause
# the circle around the reticle signifying that an item can be interacted with
@onready var reticle_circle := $Overlay/ReticleCircle

# how fast the reticle circle should grow/shrink
const RETICLE_ANIM_SPEED := 0.25


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		pause_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
	
	update_reticle()


func update_reticle() -> void:
	# flips between 0 and 1 depending on what the player is looking at
	var current_scale := float(player.reach_ray.get_collider() is PhysicsBody3D)
	
	# animate the reticle circle growing/shrinking
	reticle_circle.scale = Vector2(
		lerp(reticle_circle.scale.x, current_scale, RETICLE_ANIM_SPEED),
		lerp(reticle_circle.scale.y, current_scale, RETICLE_ANIM_SPEED)
	)
