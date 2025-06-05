# HUGE thanks to https://www.youtube.com/watch?v=xIKErMgJ1Yk
# for this first-person controller

class_name Player
extends CharacterBody3D

#region player parts
# head/camera of the player
@onready var head := $Head

# collision shapes for each movement state
@onready var walking_collider := $WalkingCollider
@onready var crouching_collider := $CrouchingCollider

# checks for collisions with the ceiling, used for determining if
# the player can un-crouch or not
@onready var roof_ray := $RoofRay
# allows the player to pick up items from a short distance away
@onready var reach_ray := $Head/ReachRay
#endregion

#region movement/camera attributes
const WALKING_SPEED := 5.0
const CROUCHING_SPEED := 2.0
# height of the player's head when walking
const WALKING_DEPTH := 1.8
# height of the player's head when crouching
const CROUCHING_DEPTH := 0.9
# how quickly the player ducks down and rises back up
const HEAD_MOVE_MULTIPLIER := 15.0

# value used when actually calculating movement
var current_speed := WALKING_SPEED
# value used when determining how high or low the player's head should be
var current_head_depth := WALKING_DEPTH
# current movement state (walking or crouching?)
var crouching := false

# how quickly the player speeds up and slows down
const MOMENTUM := 25.0
# movement direction in 3D space
var direction := Vector3.ZERO

# mouse sensitivity
const MOUSE_SENS := 0.25
#endregion


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# MOVEMENT ====================================================================
func _physics_process(delta: float) -> void:
	# toggleable crouching
	if Input.is_action_just_pressed("crouch"):
		if crouching and not roof_ray.is_colliding():
			# only stand up if there isn't anything above them (such as a ceiling)
			current_speed = WALKING_SPEED
			current_head_depth = WALKING_DEPTH
			crouching = not crouching
			swap_colliders()
		elif not crouching:
			# make the player crouch
			current_speed = CROUCHING_SPEED
			current_head_depth = CROUCHING_DEPTH
			crouching = not crouching
			swap_colliders()
	
	# move head based on current state
	head.position.y = lerp(head.position.y, current_head_depth, delta * HEAD_MOVE_MULTIPLIER)


func move(delta: float) -> void:
	# get input direction and calculate movement direction
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	direction = lerp(
		direction,
		(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),
		delta * MOMENTUM
	)
	
	# handle movement
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	
	move_and_slide()


func swap_colliders() -> void:
	walking_collider.disabled = not walking_collider.disabled
	crouching_collider.disabled = not crouching_collider.disabled


# LOOKING AROUND ==============================================================
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# left-and-right head movement
		# rotate PLAYER around the player's Y-axis based on the mouse's X-axis movement
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENS))
		# up-and-down head movement
		# rotate HEAD around the head's X-axis based on the mouse's Y-axis movement
		head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENS))
		
		# clamp head rotation so player can't invert their head
		# (very painful from what I've heard)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
