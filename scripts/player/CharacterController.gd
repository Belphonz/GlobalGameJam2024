extends CharacterBody2D

var HP = 100.0
@export var MAX_HP = 100.0
@export var MOVEMENT_SPEED = 300.0
@export var BULLET_SPEED = 400.0
@export var FIRERATE = 0.2
var move_direction
@export var BOUNCEPOWER = 0.05

func Controller():
	var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var point_direction = get_global_mouse_position()
	point_direction = point_direction.normalized()
	velocity = move_direction * MOVEMENT_SPEED
	move_and_slide()
	
func Bounce(): # Give up for Now FR BRO
	var Pivot = get_child(2) as Node2D
	global_position = Pivot.position + (global_position - Pivot.position).rotated(BOUNCEPOWER)
	if rotation_degrees == 1 or rotation_degrees == 359:
		BOUNCEPOWER = BOUNCEPOWER * -1
	print(rotation_degrees)	
	#look_at(Pivot.position)

func _physics_process(delta):
	Controller()
	#Bounce()
