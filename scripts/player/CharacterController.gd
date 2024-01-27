extends CharacterBody2D

var HP:float = 100.0
@export var MAX_HP:float = 100.0
@export var MOVEMENT_SPEED:float = 300.0
@export var BULLET_BOUNCE_COUNT:int = 3
@export var BULLET_SPEED:float = 400.0
@export var FIRE_RATE:float = 1
var CURRENT_FIRE_RATE = 0
var move_direction


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
	
	

func _physics_process(delta):
	Controller()
	Shoot(delta)
	#Bounce()
