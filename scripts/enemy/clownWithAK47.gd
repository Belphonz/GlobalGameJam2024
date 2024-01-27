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

<<<<<<< HEAD
@export
var firingRange:float=100.0
@export
var rangeRange:float=40.0

=======
<<<<<<< Updated upstream
=======
@export
var firingRange:float=400.0
@export
var rangeRange:float=100.0

>>>>>>> Stashed changes
>>>>>>> ClownWithAK47
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
<<<<<<< HEAD
	
	var distFromPlayer:float=(Player.get_global_position().distance_to(get_global_position()))
	
	if(!weaponActive):	#If weapon is cooling down, handle cooldown timer, done before checking range as weapon will cooldown when 
		
=======
<<<<<<< Updated upstream
	attackTimer+=delta
	if(attackTimer>=attackSpeed):
		
=======
	
	var distFromPlayer:float=(Player.get_global_position().distance_to(get_global_position()))
	
	if(!weaponActive):	#If weapon is cooling down, handle cooldown timer, done before checking range as weapon will cooldown when 
		
>>>>>>> ClownWithAK47
		cooldownTimer+=delta
		if(cooldownTimer>cooldownTime):
			cooldownTimer=0
			attackingTimer=0
			weaponActive=true
			
	if(abs(distFromPlayer-firingRange)>rangeRange):	#If player is outside of firing range, don't attack
		if(weaponActive):
			attackingTimer=0
		return
	
	
<<<<<<< HEAD
	
	attackTimer+=delta
	attackingTimer+=delta;
	if(attackTimer>=attackSpeed):
=======
	attackTimer+=delta	#Update timers
	attackingTimer+=delta;
	
	if(attackTimer>=attackSpeed && weaponActive):
>>>>>>> Stashed changes
>>>>>>> ClownWithAK47
		var cosOffset:float=cos(offset)	#Get fire direction with offset
		var sinOffset:float=sin(offset)
		var attackDirection:Vector2=Vector2(cosOffset*playerDirection.x-sinOffset*playerDirection.y,sinOffset*playerDirection.x+cosOffset*playerDirection.y)
		
		offset+=fireChange#Adjust offset
		
		if(abs(offset)>fireCone):	#Flip direction of bullet movement
			fireChange*=-1
			offset+=fireChange
		
		attackTimer=0
<<<<<<< Updated upstream
		print(offset)		#TODO: Add shooting bullet
<<<<<<< HEAD
		
	if(attackingTimer>=firingTime):	#Weapon deactivates after firing for too long
		weaponActive=false
=======
=======
		print("offsetFIRE")		#TODO: Add shooting bullet
		
	if(attackingTimer>=firingTime):	#Weapon deactivates after firing for too long
		weaponActive=false
>>>>>>> Stashed changes
>>>>>>> ClownWithAK47

func move(delta):
	
	var distFromPlayer:float=(Player.get_global_position().distance_to(get_global_position()))
	
	if(abs(distFromPlayer-firingRange)<rangeRange):	##Enemy is at optimal range, don't move
		return
		
	var direction:int=sign(distFromPlayer-firingRange)
	
	velocity=playerDirection * moveSpeed * direction
	move_and_slide()
