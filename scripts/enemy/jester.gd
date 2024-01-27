extends "res://scripts/enemy/baseEnemy.gd"

var nailHazard
var bellBullet

@export
var _moveSpeed:float = 60

@export
var zigzagAngle:float=1.0/6.0 * PI  	#1/6PI radians (30 degrees)
@export 
var zigTime:float=1	#How often it swaps between zig zag direction

@export
var attackSpeed:float=0.2
@export_range (0,1)
var nailChance:float=0.15

@export
var nailThrowDistance:float=128
@export
var bellThrowDistance:float=128


var zigLeft:bool=false	#Jester moves in a zig zag, are they zigging or zagging

var zigzagTimer:float=0.5	#Track how often zigLeft should swap

var attackTimer:float=0

var rng=RandomNumberGenerator.new()

func start(_Player, _maxHealth):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	nailHazard=preload("res://elements/hazards/nailHazard.tscn")
	bellBullet=preload("res://elements/bullets/jesterBell.tscn")

func _process(delta):
	super._process(delta)
	
	if(HP<=0):
		onDeath()

func attack(delta):
	super.attack(delta)
	attackTimer+=delta
	if(attackTimer>attackSpeed):
		attackTimer=0
		var throwAngle:float=rng.randf()*2*PI
		var throwDirection:Vector2=Vector2(cos(throwAngle),sin(throwAngle))
		if(rng.randf()<0.15):
			#Throw trap
			var NailHazard=nailHazard.instantiate()
			NailHazard.throw(get_global_position(),get_global_position()+throwDirection*nailThrowDistance)
			get_parent().get_parent().add_child(NailHazard)
		else:
			
			#Throw bell
			var Bell=bellBullet.instantiate()
			Bell.throw(get_global_position(),get_global_position()+throwDirection*bellThrowDistance)
			get_parent().get_parent().add_child(Bell)
	
	
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
	
	
