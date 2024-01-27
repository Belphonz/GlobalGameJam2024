extends CharacterBody2D

var HP = 100.0
@export var MAX_HP = 100.0
@export var MOVEMENT_SPEED = 300.0
@export var BULLET_SPEED = 400.0
@export var FIRERATE = 0.2
@export var PLAYER_ROTATION_SPEED = 80.0
var move_direction



func _physics_process(delta):
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var point_direction = get_global_mouse_position()
	look_at(point_direction)
	point_direction = point_direction.normalized()
	velocity = move_direction * MOVEMENT_SPEED
	move_and_slide()


func _on_area_2d_area_exited(area):
	print("1")
	velocity = -move_direction * MOVEMENT_SPEED
	move_and_slide()
