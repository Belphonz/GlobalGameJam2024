extends CharacterBody2D


func _ready():
	velocity = Vector2(50, 0)

#func _process(delta):
	#velocity = Vector2.UP.rotated(direction) * speed
	#position += velocity * delta
	#if CollisionObject2D:
		#int hi = get_collider_id()
		#Vector2 get_contact_local_normal(hi)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		



