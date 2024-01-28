extends "res://scripts/enemy/baseEnemy.gd"

@export
var _moveSpeed:float=100

@export 
var attackSpeed:float=2.0

@export
var throwDistance:float=64.0

@export
var changeDirectionTime:float=4

@export
var maxAngleChange:float=15.0

var grenade

var attackTimer:float=0

var changeDirectionTimer:float=0
var moveDirection:Vector2

var rng=RandomNumberGenerator.new()

func start(_Player, _maxHealth):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	grenade=preload("res://elements/bullets/grenade.tscn")
	maxAngleChange*=PI / 180	#Convert angle to radians
	
	var startAngle=rng.randf()*2*PI	#Get move direction
	moveDirection=Vector2(cos(startAngle),sin(startAngle))
	
func _process(delta):
	super._process(delta)
	
	
func move(delta):
	changeDirectionTimer+=delta
	if(changeDirectionTimer>changeDirectionTime):
		changeDirectionTimer=0
		var startAngle=rng.randf()*2*PI	#Get move direction
		var cosAngle=cos(startAngle)
		var sinAngle=sin(startAngle)
		
		moveDirection=Vector2(cosAngle*moveDirection.x-sinAngle*moveDirection.y,sinAngle*moveDirection.x+cosAngle*moveDirection.y)	#Rotate move direction
	
	velocity=moveDirection*moveSpeed
	
	move_and_slide()
	super.move(delta)
	
func attack(delta):
	attackTimer+=delta
	if(attackTimer>attackSpeed):
		
		var throwAngle:float=rng.randf()*2*PI	#Get throw direction
		var throwDirection:Vector2=Vector2(cos(throwAngle),sin(throwAngle))
		
		var grenadeI:Node2D=grenade.instantiate()
		grenadeI.throw(get_global_position(),get_global_position())
		get_node("../../BulletObject").add_child(grenadeI)
