extends "res://scripts/enemy/baseEnemy.gd"

@export
var _moveSpeed:float = 90
var attacking:bool = false
var stunned:bool = false
var willAttack:bool = false

var downtimeTimer:float = 0
var attackTimer:float = 0
var stunTimer:float = 0

var downtimeVal:float = 5.0
var attackLimit:float = 2.5
var stunLimit:float = 1.5

var RmId

func _process(delta):
	super._process(delta)
	
func Start(_Player, _maxHealth, id):
	super.start(_Player,_maxHealth)
	moveSpeed=_moveSpeed
	RmId = id
	
func attack(delta):
	var spinColl = get_child(1) as CollisionPolygon2D
	var bodyColl = get_child(3) as CollisionShape2D
	if attacking == false:
		spinColl.disabled = true
		bodyColl.disabled = false
		downtimeTimer+=delta
		name = "Enemy Ringmaster" + str(RmId) 
	if downtimeTimer >= downtimeVal && willAttack:
		attacking = true
		spinColl.disabled = false
		bodyColl.disabled = true
		attackTimer += delta
		name = "RingmasterSpin Bouncy" + str(RmId) 
		if attackTimer > attackLimit:
			stunned = true
			stunTimer = 0
			downtimeTimer = 0
			attackTimer = 0
			spinColl.disabled = true
			bodyColl.disabled = false
			willAttack = false
			attacking = false
	if stunned:
		stunTimer += delta
		if stunTimer >= stunLimit:
			stunTimer = 0
			downtimeTimer = 0
			stunned = false
		
	

@export var BOUNCEPOWER = 1.5
@export var DEGREES = 15
@export var BOUNCEHEIGHT = 1.5
@export var BOUNCEY = 0.4

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

func move(delta):
	var animation = get_child(0) as AnimatedSprite2D
	var sprite = get_child(4) as AnimatedSprite2D
	
	var distFromPlayer:float=(Player.get_global_position().distance_to(get_global_position()))
	
	if distFromPlayer < 100:
		willAttack = true
	
	if stunned == false:
		if attacking == false:
			BOUNCEPOWER = 0.7
			moveSpeed = 60
			sprite.play("Idle",0,false)
			sprite.visible = true
			animation.visible = false
			
		if attacking == true:
			BOUNCEPOWER = 2
			moveSpeed = 90
			animation.play("Spin",1,false)
			sprite.visible = false
			animation.visible = true
			print("SPIN MOVE")
		velocity=playerDirection * moveSpeed
		move_and_slide()
		bounce()
		
	if stunned == true:
		#animation.play("Stun",0,false)
		sprite.play("Idle",0,false)
		sprite.visible = true
		animation.visible = false
		
		sprite.rotation_degrees = 0
	
	
