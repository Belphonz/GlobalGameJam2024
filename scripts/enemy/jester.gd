extends "res://scripts/enemy/baseEnemy.gd"

@export
var _moveSpeed:float = 60

@export
var zigzagAngle:float=1.0/6.0 * PI  	#1/6PI radians (30 degrees)
@export 
var zigTime:float=1	#How often it swaps between zig zag direction

var zigLeft:bool=false	#Jester moves in a zig zag, are they zigging or zagging

var zigzagTimer:float=0.5	#Track how often zigLeft should swap

func start(_Player, _maxHealth):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed

func _process(delta):
	super._process(delta)

func attack(delta):
	super.attack(delta)
	
func move(delta):
	super.move(delta)
	
	var angle:float=zigzagAngle * (-1 if zigLeft else 1)
	
	var cosAngle:float=cos(angle)
	var sinAngle:float=sin(angle)
	
	var moveDirection=Vector2(cosAngle*playerDirection.x-sinAngle*playerDirection.y,sinAngle*playerDirection.x+cosAngle*playerDirection.y)
	
	velocity = moveDirection * moveSpeed
	move_and_slide()
	
	zigzagTimer+=delta	#Swa
	if(zigzagTimer>zigTime):
		zigLeft=!zigLeft
		zigzagTimer=0
	
	
