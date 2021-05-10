extends KinematicBody2D

onready var raycast = $RayCast2D

const SPEED = 600

var velocity = Vector2()


func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "pathogen":
			coll.kill()


func set_bullet_direction(direction):
	velocity = direction * SPEED
