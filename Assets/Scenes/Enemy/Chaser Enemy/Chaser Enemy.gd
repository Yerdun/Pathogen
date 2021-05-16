extends "res://Assets/Scenes/Enemy/Basic Enemy/Enemy.gd"

export var speed = 240	# How fast the enemy moves towards the player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../Player".is_dead:
		linear_velocity = Vector2.ZERO	# Stop moving after killing player to give breathing room
	
	else:
		var chargePosition = $"../Player".get_position()	# Get player position each frame
		linear_velocity = speed * Vector2(cos(chargePosition.angle_to_point(position)), sin(chargePosition.angle_to_point(position)))	# Move towards player at specified speed [speed scalar * <cos(theta), sin(theta)> where theta is angle between player and enemy]
