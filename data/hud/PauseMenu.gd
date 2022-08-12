extends Node2D

var bgPolygons = PoolVector2Array()\

func _process(delta):
	update()

func _draw():
	var bgPoints = PoolVector2Array()
	var color = PoolColorArray()
	bgPoints = [Vector2(100,100), Vector2(200,100), Vector2(200,200),Vector2(100,200)]
	color = [Color(0, 0, 0, 1)]
	draw_polygon(bgPoints, color)
	
func _ready():
	set_process(true)
