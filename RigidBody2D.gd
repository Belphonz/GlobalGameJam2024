extends RigidBody2D

var speed = 70 #Pixels per second
var direction = 0 #Radians
var velocity
var bodyState:PhysicsDirectBodyState2D

func _process(delta):
	velocity = Vector2.RIGHT.rotated(direction) * speed
	position += velocity * delta
	#if CollisionObject2D:
		#int hi = get_collider_id()
		#Vector2 get_contact_local_normal(hi)

func on_body_entered(body):
	speed = speed * -1
	var colnormal = bodyState.get_contact_local_normal(body)
	print(colnormal)

func _integrate_forces(state):
	bodyState = state
	pass # Replace with function body.
