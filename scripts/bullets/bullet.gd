extends CharacterBody2D

var speed : float = 200
var maxBounceCount : int = 10
var bounceCount : int = 0
var direction

func _ready():
	velocity = direction * speed

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		bounceCount += 1
		print(bounceCount)
		velocity = velocity.bounce(collision_info.get_normal())
	if bounceCount == maxBounceCount:
		queue_free()
		



