extends KinematicBody2D
class_name Player

onready var animatedSprite = $Sprite
onready var collisionMask = $PlayerCollision
onready var ghostShadow = $GhostShadow
onready var collisionQuery = $Query

onready var checkPoint

#Platformer Movement Variables
var dir = Vector2()

# Horizontal Based
var isGroundPound = false
var velocity = Vector2.ZERO
var maxSpeed = 180
var friction = 0.2


# Vertical Based
var gravity = 24
var jumpLength = 455
var canJump = false
var isJumping = false
var wallSlideSpeed = 80

# Debug Based
var isNoClip = false

# Melee variables
var isAttacking = false

func coyoteTime():
	if not canJump:
		yield(get_tree().create_timer(10), "timeout")
		canJump = false
		isJumping = false
	
func jump():
	if canJump and not isJumping:
		velocity.y = -jumpLength 
		isJumping = true
		if is_on_wall() and dir.x == 1:
			velocity.x = -maxSpeed * 2
		elif is_on_wall() and dir.x == -1:
			velocity.x = maxSpeed  * 2
func die():
	position = checkPoint
func _ready():
	checkPoint = Vector2(position)

func _physics_process(_delta):

	dir = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	var isJumpInterrupted = Input.is_action_just_released("A") and velocity.y < 0.0 
	#Engine.time_scale = 0.5
	
	if Global._debugMode:
		if Input.is_action_just_pressed("B"):
			if isNoClip:
				isNoClip = false
			else:
				isNoClip = true
	
	if not isNoClip:
		if is_on_floor():
			# Some Animation stuff
			
			if dir.x != 0:
				animatedSprite.animation = "Run"
			elif dir.x == 0:
				animatedSprite.animation = "Idle"
			if dir.y == 1:
				animatedSprite.animation = "Frames"
				animatedSprite.set_frame(0)
				
			canJump = true
			isJumping = false
		
		if not is_on_floor() and not is_on_wall():
			
			if velocity.y > 0:
				animatedSprite.set_frame(2)
				animatedSprite.animation = "Frames"
				
			elif velocity.y < 0:
				animatedSprite.set_frame(1)
				animatedSprite.animation = "Frames"
				
			coyoteTime()
			
		if dir.x > 0: #Going Right
			animatedSprite.flip_h = false
				
		elif dir.x < 0: #Going Left
			animatedSprite.flip_h = true
			
			
	# The movement itself:
		
		#Friction (Acceleration and Decceleration
		
		if dir.x != 0 and dir.y != 1:
			velocity.x = lerp(velocity.x, dir.x * maxSpeed, friction)
		else:
			velocity.x = lerp(velocity.x, 0, friction)
			
		# Jumping
		
		if Input.get_action_strength("A"):
			jump()
				
		if is_on_wall() and dir.x != 0:
			canJump = true
			isJumping = false
			animatedSprite.animation = "Frames"
			animatedSprite.set_frame(3)
			if dir.x == 1:
				animatedSprite.flip_h = true
			elif dir.x == -1:
				animatedSprite.flip_h = false
			if velocity.y >= 0:
				velocity.y = wallSlideSpeed
			else:
				velocity.y = velocity.y + gravity	
		else:
			velocity.y = velocity.y + gravity
			
		if Input.is_action_pressed("X"):
			maxSpeed = 240
		else: maxSpeed = 180
		
		collisionMask.disabled = false
		
		if collisionQuery.overlaps_body($"../Placeholder Hazards"):
			die()
		
		if isJumpInterrupted: #Smoothly multiply the Y Velocity as the jump button is released
			velocity.y *= 0.55
		velocity = move_and_slide(velocity, Vector2.UP)
		
		ghostShadow.emitting = false
		
	else:
	
	#Noclip ghost movement for debugging purposes
	
		animatedSprite.animation ="Ghost"
		velocity = dir * maxSpeed 
		if Input.is_action_pressed("A"):
			maxSpeed = 480
		elif Input.is_action_pressed("X"):
			maxSpeed = 640
		else:
			maxSpeed = 180
		# warning-ignore:return_value_discarded
		move_and_slide(velocity)
		collisionMask.disabled = true
		ghostShadow.emitting = true
