extends "res://scripts/enemy/baseEnemy.gd"

var Bullet:Node2D
@export
var attackSpeed:float=0.2
@export
var firingTime:float=4.0
@export 
var cooldownTime:float = 1.0
@export
var _moveSpeed:float = 60
@export
var fireCone:float = 1/4.0 * PI
@export
var fireChangeRate:float = 1/32.0 * PI

@export
var firingRange:float=100.0
@export
var rangeRange:float=40.0

var offset:float=0
var fireChange=fireChangeRate
var weaponActive:bool=true
var movingToRange:bool=true

var attackTimer:float=0 		#Time between shots, time shooting continuously, time with weapon cooling down
var attackingTimer:float=0
var cooldownTimer:float=0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	

func start(_Player, _maxHealth):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	
func attack(delta):	#Function called every frame
	
	var distFromPlayer:float=(Player.get_global_position().distance_to(get_global_position()))
	
	if(!weaponActive):	#If weapon is cooling down, handle cooldown timer, done before checking range as weapon will cooldown when 
		
		cooldownTimer+=delta
		if(cooldownTimer>cooldownTime):
			cooldownTimer=0
			attackingTimer=0
			weaponActive=true
			
	if(abs(distFromPlayer-firingRange)>rangeRange):	#If player is outside of firing range, don't attack
		if(weaponActive):
			attackingTimer=0
		return
	
	
	
	attackTimer+=delta
	attackingTimer+=delta;
	if(attackTimer>=attackSpeed):
		var cosOffset:float=cos(offset)	#Get fire direction with offset
		var sinOffset:float=sin(offset)
		var attackDirection:Vector2=Vector2(cosOffset*playerDirection.x-sinOffset*playerDirection.y,sinOffset*playerDirection.x+cosOffset*playerDirection.y)
		
		offset+=fireChange#Adjust offset
		
		if(abs(offset)>fireCone):	#Flip direction of bullet movement
			fireChange*=-1
			offset+=fireChange
		
		velocity+=attackDirection * 120.0
		move_and_slide()
		attackTimer=0
		print(offset)		#TODO: Add shooting bullet
		
	if(attackingTimer>=firingTime):	#Weapon deactivates after firing for too long
		weaponActive=false

func move(delta):
	velocity=playerDirection * moveSpeed
	move_and_slide()
