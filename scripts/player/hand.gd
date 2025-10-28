extends MeshInstance3D

# detects when the player is looking at something interactable
@export var reach_ray: RayCast3D

# the object currently being held by the player
var held_object: PhysicsBody3D


func _physics_process(_delta: float) -> void:
	print(held_object)
	
	if Input.is_action_just_pressed("drop") and held_object != null:
		# TODO: held object currently set to freed object, needs fixed
		# TODO: also add comments
		print("drop")
		set_held_object(null)
	
	var reach := reach_ray.get_collider()
	if reach is PhysicsBody3D and Input.is_action_just_pressed("interact"):
		# add the object to the player's hand
		set_held_object(reach)
		# remove the object from the game scene
		reach.queue_free()


func set_held_object(obj) -> void:
	held_object = obj
	mesh = held_object.get_node("MeshInstance3D").mesh
