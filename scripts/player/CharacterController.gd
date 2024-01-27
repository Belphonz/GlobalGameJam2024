extends CharacterBody2D

var HP:int = 6
@export var MAX_HP:float = 100.0
@export var MOVEMENT_SPEED:float = 300.0
@export var BULLET_BOUNCE_COUNT:int = 3
@export var BULLET_SPEED:float = 400.0
@export var FIRE_RATE:float = 0.4
var CURRENT_FIRE_RATE = 0.0
var move_direction
var bulletID = 0
@export var BOUNCEPOWER = 1.5
@export var DEGREES = 15
@export var BOUNCEHEIGHT = 1.5
@export var BOUNCEY = 0.4

var usingController:bool=false


func Controller():
	var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = move_direction * MOVEMENT_SPEED
	move_and_slide()
	
func Shoot(delta):
	var shootPoint = get_child(1) as Node2D
	var audioShoot = get_child(2) as AudioStreamPlayer2D
	var audioNoShoot = get_child(3) as AudioStreamPlayer2D
	
	CURRENT_FIRE_RATE += delta
	
	var facingdirection:Vector2	#Get direction to fire
	if(Input.get_connected_joypads().size() > 0):	#Using controller
		facingdirection=Vector2(Input.get_joy_axis(0,JOY_AXIS_RIGHT_X),Input.get_joy_axis(0,JOY_AXIS_RIGHT_Y))
		if(facingdirection.dot(facingdirection)<0.1):	#If aiming no-where
			facingdirection=Vector2(1,0)
		else:
			facingdirection=facingdirection.normalized()	#Normalize facing direction so it's not affecting bullet velocity	
	else:					#Using mouse
		facingdirection = (get_global_mouse_position() - global_position).normalized()
		
	shootPoint.rotation = facingdirection.angle()
	if Input.is_action_just_pressed("shoot") and CURRENT_FIRE_RATE < FIRE_RATE:
		audioNoShoot.play()
	if Input.is_action_pressed("shoot") and CURRENT_FIRE_RATE > FIRE_RATE:
		audioShoot.play()
		var bulletInstance:CharacterBody2D = preload("res://elements/bullets/bullet.tscn").instantiate()
		bulletInstance.speed = BULLET_SPEED
		bulletInstance.direction = facingdirection
		bulletInstance.isPlayerBullet = true
			
		bulletInstance.maxBounceCount = BULLET_BOUNCE_COUNT
		
		bulletID += 1
		bulletInstance.name = "PlBullet " + str(bulletID)
		
		bulletInstance.global_position = shootPoint.global_position + (facingdirection * 50)
		get_parent().add_child(bulletInstance)
		CURRENT_FIRE_RATE = 0
	
	
func Bounce(delta): 
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
	
func Death():
	if HP == 0:
		get_tree().change_scene_to_file("res://scenes/DeathScreen.tscn")

func _physics_process(delta):
	Controller()
	Bounce(delta)
	
	Shoot(delta)
	Death()


func _on_player_collider_area_entered(area):
	if "Bullet" in area.owner.name:
		HP -= 1
