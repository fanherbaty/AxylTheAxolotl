extends Node2D

func _physics_process(_delta):
	
	#Offset of the sprites (+1 every frame)
	
	$"Background/Layer #1".set_motion_offset($"Background/Layer #1".get_motion_offset() - Vector2(0.3, 0.3))
	$"Background/Layer #2".set_motion_offset($"Background/Layer #2".get_motion_offset() + Vector2(0.4, 0.4))
	
	#Movement of the logo
	
	$Logo/Scarf.rotate(Global._sineMovement(330, 2, true))
	$Logo/Scarf.position.y += Global._sineMovement(8, 2, false)
	$Logo/Text.position.y += Global._sineMovement(8, 2, false)
	
	$"Play Button/Text".position.y += Global._sineMovement(12, 2, false)
	$"Play Button/Sunflower".position.y += Global._sineMovement(12, 2, true)
	$"Play Button/Ray".rotation += 0.01
