extends Node2D
class_name HUDTopScreen

onready var sunflowerCounter = $"Sunflower Counter/Counter"

func _physics_process(_delta):
	sunflowerCounter.set_text(str(Global._sunflowerAmount))
