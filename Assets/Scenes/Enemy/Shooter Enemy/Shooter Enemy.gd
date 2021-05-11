extends "res://Assets/Scenes/Enemy/Basic Enemy/Enemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Hitbox".shape.extents = Vector2(32,24)	# Hitbox better fits sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Enemy starts out moving, opposite force slows it to a halt
	if linear_velocity.x >= 0:	# When the force pushes it enough to move right
		applied_force = Vector2.ZERO	# Stop the enemy (no force, no velocity)
		linear_velocity.x = 0
		
#		var look_vec = get_global_mouse_position() - global_position
#		global_rotation = atan2(look_vec.y, look_vec.x)
#		Pseudocode stub:
#			Get direction of player at the current frame (may need to make its own function)
#			Turn sprite in said direction (take half a second to do so)
#			Instantiate bullet
#			Turn it in said direction
#			Set linear velocity of bullet to 400 (This has the effect of shooting bullets aimed at the player)
#			Do this until ten bullets are fired
#			Wait one second
#			Move and rotate the enemy in the direction of the player
#			Set speed to -500 (normalised in player direction) and force to 450
#			(Then the process should start over)
			
