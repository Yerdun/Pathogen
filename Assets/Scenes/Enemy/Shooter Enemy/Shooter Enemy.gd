extends "res://Assets/Scenes/Enemy/Basic Enemy/Enemy.gd"

export (PackedScene) var bullet

export var bulletsToShoot = 8	# How many bullets the enemy will shoot
export var startingVelocity = 660	# The velocity the enemy enters the scene with
export var stoppingForce = -880	# The counteractive force that stops the enemy
var isShooting	# Boolean used to store shooting status


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Hitbox".shape.extents = Vector2(32,24)	# Hitbox better fits sprite
	isShooting = false	# Enemy starts off not shooting
	linear_velocity.x = -startingVelocity	# Upon entering the scene, moves in from the left at starting velocity
	applied_force.x = -stoppingForce	# This force slows it down to a halt

func _physics_process(delta):
	# Enemy starts out moving, opposite force slows it to a halt
	if linear_velocity.dot(applied_force) > 0:	# Dot product is negative if two vectors are in opposite directions. but turns positive when they're in the same direction. So when the force is enough to turn the object in the other direction...
		applied_force = Vector2.ZERO	# Stop the enemy (no force, no velocity)
		linear_velocity.x = 0
		if !isShooting:	# If the enemy is currently not shooting
			_shoot(bulletsToShoot)	# Shoot at the player


func _shoot(numBullets):
	isShooting = true	# Set isShooting to true, so the enemy doesn't infinitely shoot
	
	for i in numBullets: # Repeat this for each bullet
		var newBullet = bullet.instance() # Instantiate bullet
		newBullet.position = position - Vector2(28, 0)	# Bullets spawn from the yellow part of the sprite
		var playerPosition = $"../Player".get_position()	# Get Player's position (this is a vector)
		
		newBullet.direction = position.direction_to(playerPosition)	# Set bullet's direction to the angle towards player
		newBullet.get_node("Sprite").rotation = position.angle_to_point(playerPosition)	# Rotate bullet to face player
		newBullet.get_node("Hitbox").rotation = position.angle_to_point(playerPosition)	# Rotate bullet's hitbox accordingly
		
		get_parent().add_child(newBullet)	# Spawn the bullet
		$"Shooting Sound".play()	# Play the bullet shot sound
		yield(get_tree().create_timer(0.16), "timeout")	# Wait 0.16 seconds between each shot
	
	yield(get_tree().create_timer(2), "timeout")	# Wait 2 seconds after firing
	var chargePosition = $"../Player".get_position()	# Need to get player position again, since this is out of the loop
	linear_velocity = startingVelocity * Vector2(cos(chargePosition.angle_to_point(position)), sin(chargePosition.angle_to_point(position)))	# When neutralised, this should move towards the player at the starting velocity. My vector mathematics might be off
	applied_force = stoppingForce * Vector2 (cos(chargePosition.angle_to_point(position)), sin(chargePosition.angle_to_point(position)))	# Likewise, this should be the starting force, in the opposite direction, of the angle between the enemy and the player
	isShooting = false	# Set isShooting to false, so it can shoot again
