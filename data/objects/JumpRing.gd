extends Node2D
class_name JumpRing

onready var area = $Area2D
onready var player = $"../Player"
onready var impact = $"Area2D/Feedback Ring"

var isUsed = false

func _physics_process(_delta):
	
	
	
	if area.overlaps_body(player):
	
		if not player.is_on_floor() and player.velocity.y > 0:
			player.canJump = true
			player.isJumping = false
			isUsed = true
	
	if isUsed:
		yield(get_tree().create_timer(0.1), "timeout")
		isUsed = false
	
	if isUsed:
		impact.emitting = true
	elif not isUsed:
		impact.emitting = false
