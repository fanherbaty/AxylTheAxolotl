extends Node2D
var _debugMode = false
var _time = 0
var _mousePos = Vector2(1, 1)
var _sunflowerAmount = 0
var _inGame = false
var windowSize = 3

onready var _cursor = get_node("/root/Cursor/Cursor")
onready var _debugInfo = get_node("/root/DebugInfo/Label")
#onready var _cursorAxis = Vector2(0, 0)
#var _cursorVelocity = Vector2(0, 0)

func _resizeWindow(size, screen):
	
	#Multiplies the Screen size by the SIZE parameter.
	#Could be useful for settings
	
	OS.set_window_size(Vector2(288 * size, 176 * size)) 
	OS.set_window_resizable(false)
	OS.center_window()
	print('Resized the window ', size, ' times on screen ', screen + 1, '. ', OS.get_window_size(), ' ', OS.get_screen_position())
	
func _sineMovement(amplitude, freq, cosine):
	#The sine movement used for e.g. Sunflowers, Main Menu Logo
	if cosine:	
		return cos(_time*freq) / amplitude
	else:
		return sin(_time*freq) / amplitude

func _ready():
	_resizeWindow(windowSize, 0)
	
func _physics_process(delta):
	
	_mousePos = Vector2(get_viewport().get_mouse_position())
	_time += delta
	
	_cursor.position = _mousePos
	_debugInfo.set_text(str("= DEBUG = \n FPS:", Engine.get_frames_per_second(), "\n Mouse Pos:", round(_mousePos.x), " ", round(_mousePos.y)))
	_debugInfo.visible = _debugMode
	
	# TODO: Add cursor movement by controller (for later)
	
#	_cursorAxis = Vector2(Input.get_action_strength("cursor_right") - Input.get_action_strength("cursor_left"), Input.get_action_strength("cursor_up") + Input.get_action_strength("cursor_down"))
#
#	if _cursorVelocity < Vector2(150, 150):
#		_cursorVelocity = _cursorVelocity + _cursorAxis
#	elif _cursorVelocity > Vector2(150, 150):
#		_cursorVelocity = _cursorVelocity
	
	if Input.is_action_just_released("debug"):
		if not _debugMode:
			print('Debug Mode is now On')
			_debugMode = true
		elif _debugMode:
			print('Debug Mode is now Off')
			_debugMode = false
	
	if _debugMode:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		
#	_cursor.position += _cursorVelocity
#	clamp(_cursor.position.x, 0, 288)
#	clamp(_cursor.position.y, 0, 176)
	
