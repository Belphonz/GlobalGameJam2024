extends "res://scripts/enemy/baseEnemy.gd"

var Bullet:Node2D
@export
var attackSpeed:float=0.2
@export
var _moveSpeed:float = 0.5
@export
var fireCone:float = 1/4.0 * PI
@export
var fireChangeRate:float = 1/32.0 * PI

<<<<<<< Updated upstream
=======
@export
var firingRange:float=400.0
@export
var rangeRange:float=100.0

>>>>>>> Stashed changes
var offset:float=0
var fireChange=fireChangeRate

var attackTimer:float=0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	

func start(_Player, _maxHealth):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	
func attack(delta):	#Function called every frame
<<<<<<< Updated upstream
	attackTimer+=delta
	if(attackTimer>=attackSpeed):
		
=======
	
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
	
	
	attackTimer+=delta	#Update timers
	attackingTimer+=delta;
	
	if(attackTimer>=attackSpeed && weaponActive):
>>>>>>> Stashed changes
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
=======
		print("offsetFIRE")		#TODO: Add shooting bullet
		
	if(attackingTimer>=firingTime):	#Weapon deactivates after firing for too long
		weaponActive=false
>>>>>>> Stashed changes

func move(delta):
	
	var distFromPlayer:float=(Player.get_global_position().distance_to(get_global_position()))
	
	if(abs(distFromPlayer-firingRange)<rangeRange):	##Enemy is at optimal range, don't move
		return
		
	var direction:int=sign(distFromPlayer-firingRange)
	
	velocity=playerDirection * moveSpeed * direction
	move_and_slide()
