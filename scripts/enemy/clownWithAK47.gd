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
	attackTimer+=delta
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

func move(delta):
	velocity=playerDirection * moveSpeed
	move_and_slide()
