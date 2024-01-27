extends CharacterBody2D

var HP = 100.0
@export var MAX_HP = 100.0
@export var MOVEMENT_SPEED = 300.0
@export var BULLET_SPEED = 400.0
@export var FIRERATE = 0.2
var move_direction
@export var BOUNCEPOWER = 2
@export var DEGREES = 15
@export var BOUNCEHEIGHT = 1.5
@export var BOUNCEY = 0.4
	
func Controller():
	var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var point_direction = get_global_mouse_position()
	point_direction = point_direction.normalized()
	velocity = move_direction * MOVEMENT_SPEED
	move_and_slide()
	
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
