extends CharacterBody2D

var HP:int = 1
@export var MAX_HP:int = 6
@export var MOVEMENT_SPEED:float = 300.0
@export var BULLET_BOUNCE_COUNT:int = 3
@export var BULLET_SPEED:float = 400.0
@export var FIRE_RATE:float = 0.4
var CURRENT_FIRE_RATE = 0.0
var move_direction
var lastsaved_move_direction
var bulletID = 0
@export var BOUNCEPOWER = 1.5
@export var DEGREES = 15
@export var BOUNCEHEIGHT = 1.5
@export var BOUNCEY = 0.4
@export var iFrameTime:float=2.0
var scoretimer = 0
@export var score : float= 0
var alive = true
var LastHitBy : String


@export var DashSpeedmultiplier : float = 4
@export var Dashduration : float = 0.3
var currentDashduration : float = 0
var isDashing : bool

var usingController:bool=false
var iFramesActive:bool=false
var iFramesTimer:float=0

var isLeft : bool = false
var rotationFrame : int
func _ready():
	Highscore.Player = self


func Controller(delta):
	if not isDashing:
		move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
		lastsaved_move_direction = move_direction
	
	if Input.is_action_just_pressed("dash") and not isDashing:
		isDashing = true
	if isDashing:
		velocity = lastsaved_move_direction * MOVEMENT_SPEED * DashSpeedmultiplier
	else:
		velocity = move_direction * MOVEMENT_SPEED
	
	if isDashing:
		currentDashduration += delta
	if currentDashduration > Dashduration: 
		currentDashduration = 0
		isDashing = false
	var leftDirection = [0,1,7]
	
	var animation = get_child(0) as AnimatedSprite2D
	animation.frame = rotationFrame
	
	if move_direction:
		Bounce(delta)
		rotationFrame = roundi(((move_direction.angle() + PI) * 4)/ PI);
		if rotationFrame > 7:
			rotationFrame -= 8
		if rotationFrame in leftDirection:
			isLeft = true
		else:
			isLeft = false
	else:
		animation.rotation = 0
	animation.flip_h = isLeft
	animation.play("Default",0,false)
	move_and_slide()
	
func Shoot(delta):
	var shootPoint = get_child(1) as Node2D
	var audioShoot = get_child(2) as AudioStreamPlayer2D
	var audioNoShoot = get_child(3) as AudioStreamPlayer2D
	
	CURRENT_FIRE_RATE += delta
	
	var facingdirection:Vector2	#Get direction to fire
	if(Input.get_connected_joypads().size() > 0):	#Using controller
		facingdirection=Vector2(Input.get_joy_axis(0,JOY_AXIS_RIGHT_X),Input.get_joy_axis(0,JOY_AXIS_RIGHT_Y))
		if(facingdirection.dot(facingdirection)<0.1):	#If aiming no-where
			facingdirection=Vector2(1,0)
		else:
			facingdirection=facingdirection.normalized()	#Normalize facing direction so it's not affecting bullet velocity	
	else:					#Using mouse
		facingdirection = (get_global_mouse_position() - global_position).normalized()
		
	shootPoint.rotation = facingdirection.angle()
	if Input.is_action_just_pressed("shoot") and CURRENT_FIRE_RATE < FIRE_RATE:
		audioNoShoot.play()
	if Input.is_action_pressed("shoot") and CURRENT_FIRE_RATE > FIRE_RATE:
		audioShoot.play()
		var bulletInstance:CharacterBody2D = preload("res://elements/bullets/bullet.tscn").instantiate()
		bulletInstance.speed = BULLET_SPEED
		bulletInstance.direction = facingdirection
		bulletInstance.isPlayerBullet = true
			
		bulletInstance.maxBounceCount = BULLET_BOUNCE_COUNT
		
		bulletID += 1
		bulletInstance.name = "PlBullet " + str(bulletID)
		
		bulletInstance.global_position = shootPoint.global_position + (facingdirection * 30)
		get_parent().add_child(bulletInstance)
		CURRENT_FIRE_RATE = 0
	
	
func Bounce(delta): 
	var sprite = get_child(0) as Node2D
	# rotates only sprite and flips if over the limit
	sprite.rotate(BOUNCEPOWER * (PI/180))
	if sprite.rotation_degrees >= DEGREES or sprite.rotation_degrees <= -DEGREES:
		BOUNCEPOWER = BOUNCEPOWER * -1
		rotate(BOUNCEPOWER * (PI/180))
	sprite.move_local_y(BOUNCEY, false)
	if sprite.position.y >= BOUNCEHEIGHT or sprite.position.y <= -BOUNCEHEIGHT:
		BOUNCEY = BOUNCEY * -1
		sprite.move_local_y(BOUNCEY, false)
	
func Death():
	score = floor(scoretimer) * 10
	Highscore.runscore = score
	alive = false
	ProcessDeath()
	var DeathScreen : Node2D = preload("res://scenes/DeathScreen.tscn").instantiate()
	(DeathScreen.get_node("Deathmessasage") as Label).text = LastHitBy
	get_tree().root.add_child(DeathScreen)
	get_tree().root.remove_child(get_tree().root.get_child(1))
	
func ProcessDeath():
	if "PlBullet" in LastHitBy :
		LastHitBy = "YOURSELF, IDIOT !"
	elif "EnBullet" in LastHitBy :
		LastHitBy = "THE AK CLOWN's NONSTOP SPRAY!"
	elif "ClownAK47" in LastHitBy :
		LastHitBy = "THE AK CLOWN's BELLYFLOP!"
	elif "Ringmaster" in LastHitBy :
		LastHitBy = "THE RINGMASTER's BELLYFLOP!"

func Scorecounter(delta):
	if alive:
		scoretimer += delta
	else:
		var highscore : Label = get_node("../HighscoreManager").get_child(0)
	
func _physics_process(delta):
	Controller(delta)

	if(iFramesActive):
		iFramesTimer+=delta
		if(iFramesTimer>iFrameTime):
			iFramesTimer=0
			iFramesActive=false	
	
	Shoot(delta)
	Scorecounter(delta)
	if HP <= 0:
		Death()
	


func _on_player_collider_area_entered(area):
	if "Bullet" in area.owner.name && !iFramesActive:
		LastHitBy = area.owner.name
		HP -= 1
		iFramesActive=true
		var Bullet:Node2D=area.get_parent()
		Bullet.death()
	if "Enemy" in area.owner.name && !iFramesActive:
		LastHitBy = area.owner.name
		HP-=1
		iFramesActive=true
		
		
	
