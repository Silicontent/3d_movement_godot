class_name PlayerState
extends State

# all of the player's possible states to avoid typos
const IDLE := "Idle"
const MOVING := "Moving"
const FALLING := "Falling"

# reference to the player
var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "State type 'PlayerState' must only be used by the player scene.")
