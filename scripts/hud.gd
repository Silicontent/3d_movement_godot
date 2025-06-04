extends CanvasLayer

@export var player: Player

@onready var pause_menu := $Pause
@onready var reticle_circle := $Overlay/ReticleCircle

const RETICLE_ANIM_SPEED := 0.25


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		pause_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
	
	update_reticle()


func update_reticle() -> void:
	var current_scale := float(player.reach_ray.get_collider() is PhysicsBody3D)
	
	reticle_circle.scale = Vector2(
		lerp(reticle_circle.scale.x, current_scale, RETICLE_ANIM_SPEED),
		lerp(reticle_circle.scale.y, current_scale, RETICLE_ANIM_SPEED)
	)
