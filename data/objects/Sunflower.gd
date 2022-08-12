extends Node2D
class_name Collectable

onready var sprite = $Area2D/Sprite
onready var sparkles = $Area2D/Sparkles
onready var player = $"../Player"
onready var area = $Area2D

var isCollected = false

func _physics_process(_delta):
	
	if area.overlaps_body(player) and not isCollected:
		isCollected = true
		Global._sunflowerAmount += 1
		sparkles.emitting = false
		
	sprite.set_frame(isCollected)
	
	if not isCollected:
		sprite.position.y = Global._sineMovement(0.5, 3, false)
