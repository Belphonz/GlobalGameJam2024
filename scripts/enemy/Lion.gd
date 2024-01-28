extends "res://scripts/enemy/baseEnemy.gd"

@export
var _moveSpeed:float=160
@export
var backToSideSpeedMult:float=0.25
@export
var pounceMult:float=1.5

@export var PHYSICAL_DAMAGE:float

@export
var pounceDist:float = 60

@export 
var minDist:float = 120

@export
var maxDist:float = 150

@export
var LionSideOffset:Vector2 = Vector2(-50,0)

var LionTamer:Node2D=null	#TODO:When lion tamer dies, find a way to signal lion, and de-reference LionTamer

var tamerAlive:bool=true

func setTamer(Tamer:Node2D):
	LionTamer=Tamer

func start(_Player, _maxHealth):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	
func freeLion():
	LionTamer=null
	tamerAlive=false

func _process(delta):
	super._process(delta)
	if HP <= 0:
		onDeath()
	
func move(delta):
	
	var sprite = get_child(0) as Node2D
	var areaToReach:Vector2
	var finalMoveSpeed:float=moveSpeed
	
	var facingDirection = ((Player.global_position - global_position).normalized())
	
	if(tamerAlive):	#If the tamer is still alive
		var playerDist:float=Player.get_global_position().distance_to(LionTamer.get_global_position())
		if(playerDist>maxDist):	#Lion is too far away to chase player
			areaToReach=LionTamer.get_global_position()+LionSideOffset
			finalMoveSpeed *= backToSideSpeedMult;
			bounce()
			if EnemySpin(facingDirection) in leftDirection:
				(sprite as AnimatedSprite2D).flip_h = true
			else:
				(sprite as AnimatedSprite2D).flip_h = false
			(sprite as AnimatedSprite2D).frame = EnemySpin(facingDirection) 
			(sprite as AnimatedSprite2D).play("Idle",0,false)
		elif(playerDist<maxDist && playerDist > minDist):	#Lion can chase player, but cannot reach player
			areaToReach=get_global_position().direction_to(Player.get_global_position())*minDist + LionTamer.get_global_position()
			rotation = 0
			if EnemySpin(facingDirection) in leftDirection:
				(sprite as AnimatedSprite2D).flip_h = true
			else:
				(sprite as AnimatedSprite2D).flip_h = false
			(sprite as AnimatedSprite2D).frame = 1
			(sprite as AnimatedSprite2D).play("Attack",0,false)
		else:	#Lion can reach player
			areaToReach=Player.get_global_position()
			rotation = 0
			
	else:	#Tamer has died
		rotation = 0
		areaToReach=Player.get_global_position()
		if EnemySpin(facingDirection) in leftDirection:
			(sprite as AnimatedSprite2D).flip_h = true
		else:
			(sprite as AnimatedSprite2D).flip_h = false
		(sprite as AnimatedSprite2D).frame =  EnemySpin(facingDirection)  
		(sprite as AnimatedSprite2D).play("Attack",0,false)
		
	if(get_global_position().distance_to(Player.get_global_position())):	#If lion should pounce
		finalMoveSpeed *= pounceMult
		
	var directionToMove:Vector2 = get_global_position().direction_to(areaToReach)
	velocity=directionToMove * finalMoveSpeed
	
	move_and_slide()
	
@export var BOUNCEPOWER = 0.5
@export var DEGREES = 10
@export var BOUNCEHEIGHT = 1.5
@export var BOUNCEY = 0.2

func bounce():
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
	
func attack(delta):
	pass
	
func onDeath():
	if LionTamer:
		LionTamer.freeTamer()
	var Blood : Node2D = BloodSplat.instantiate()
	Blood.global_position = global_position
	get_parent().get_parent().get_node("BloodsplatterNode").add_child(Blood)
	queue_free()		


func _on_enemy_collider_area_entered(area):
	if "PlBullet" in area.owner.name:
		var Bullet:Node2D=area.get_parent()
		Bullet.death()
		HP -= Bullet.damage
