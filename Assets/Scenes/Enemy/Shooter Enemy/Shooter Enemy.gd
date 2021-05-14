extends "res://Assets/Scenes/Enemy/Basic Enemy/Enemy.gd"

export (PackedScene) var bullet

export var bulletsToShoot = 10
var isShooting


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Hitbox".shape.extents = Vector2(32,24)	# Hitbox better fits sprite
	isShooting = false	# Enemy starts off not shooting

func _physics_process(delta):
	# Enemy starts out moving, opposite force slows it to a halt
	if linear_velocity.x >= 0:	# When the force pushes it enough to move right
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
	
	yield(get_tree().create_timer(1), "timeout")	# Wait 3/4 of a second after firing
	var chargePosition = $"../Player".get_position()	# Need to get player position again, since this is out of the loop
	linear_velocity = 660 * Vector2(cos(chargePosition.angle_to_point(position)), sin(chargePosition.angle_to_point(position)))	# This should charge at a one-dimensional velocity of 660 towards the player. My vector mathematics might be off
	applied_force = -880 * Vector2 (cos(chargePosition.angle_to_point(position)), sin(chargePosition.angle_to_point(position)))	# Likewise, this should be a force of 880, in the opposite direction, of the angle between the enemy and the player
	# Oddly, the two lines above sometimes causes it to freak out and oscillate up and down very rapidly. I don't know why.
	isShooting = false	# Set isShooting to false, so it can shoot again
