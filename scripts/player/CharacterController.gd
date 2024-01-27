extends CharacterBody2D

var HP:float = 100.0
@export var MAX_HP:float = 100.0
@export var MOVEMENT_SPEED:float = 300.0
@export var BULLET_BOUNCE_COUNT:int = 3
@export var BULLET_SPEED:float = 400.0
@export var FIRE_RATE:float = 1
var CURRENT_FIRE_RATE = 0
var move_direction
@export var BOUNCEPOWER = 2
@export var DEGREES = 15
@export var BOUNCEHEIGHT = 1.5
@export var BOUNCEY = 0.4
	
func Controller():
	var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_direction * MOVEMENT_SPEED
	move_and_slide()
	
func Shoot(delta):
	var shootPoint = get_child(1) as Node2D
	CURRENT_FIRE_RATE = CURRENT_FIRE_RATE + delta
	
	var facingdirection = (get_global_mouse_position() - global_position).normalized()
	shootPoint.rotation = facingdirection.angle()
	if Input.is_action_pressed("shoot") and CURRENT_FIRE_RATE > FIRE_RATE:
		var bulletInstance:CharacterBody2D = preload("res://elements/bullets/bullet.tscn").instantiate()
		bulletInstance.speed = BULLET_SPEED
		bulletInstance.direction = facingdirection
			
		bulletInstance.maxBounceCount = BULLET_BOUNCE_COUNT
		
		bulletInstance.global_position = shootPoint.global_position + (facingdirection * 20)
		get_parent().add_child(bulletInstance)
		CURRENT_FIRE_RATE = 0
	
	
func Bounce(delta): 
	var sprite = get_child(0) as Node2D
	# rotates only sprite and flips if over the limit
	sprite.rotate(BOUNCEPOWER * (PI/180))
	if sprite.rotation_degrees >= DEGREES or sprite.rotation_degrees <= -DEGREES:
		print("flip")
		BOUNCEPOWER = BOUNCEPOWER * -1
		rotate(BOUNCEPOWER * (PI/180))
	sprite.move_local_y(BOUNCEY, false)
	if sprite.position.y >= BOUNCEHEIGHT or sprite.position.y <= -BOUNCEHEIGHT:
		BOUNCEY = BOUNCEY * -1
		sprite.move_local_y(BOUNCEY, false)
	print(sprite.position)
	
	#look_at(Pivot.position)

func _physics_process(delta):
	Controller()
	Bounce(delta)
	Shoot(delta)
