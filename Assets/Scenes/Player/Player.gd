extends Area2D

export var standard_speed = 300	# Standard speed
export var focus_speed = 140	# Speed while focused (slow mode)
export var lives = 3			# Amount of player lives
var is_dead = false				# Variable used to store death status (if dead, disallow doing anything)


func _ready():
	pass # Currently unneeded, included as a stub.

func _process(delta):
	if !is_dead:	# Disallow movement when dead
		var velocity = Vector2.ZERO # Movement velocity represented as a 2 dimensional vector
		var speed = standard_speed # Speed variable. initialised to standard speed
		var is_focused = false # Tracks whether or not player is focused

		# Controls: Arrow keys to move, Shift to focus (can change in Project Settings > Input Map)
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("control_focus"):
			is_focused = true
		
		if is_focused:
			speed = focus_speed
			$FocusAnimation.play("focused") # Placeholder animation just containing 1 frame showing hitbox
		elif !is_focused:
			speed = standard_speed
			$FocusAnimation.play("default") # Placeholder blank animation
			
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed	# Set movement velocity as 1 in whichever direction

		position += velocity * delta	# Update position from previous frame
		position.x = clamp(position.x, 32, 768)	# Make sure player stays within screen boundaries
		position.y = clamp(position.y, 32, 568)

func _on_Player_body_entered(body):
	if body.is_in_group("life_extend"):
		lives += 1	# Add one life if colliding with extend
		body.queue_free()	# Remove body
	
	elif body.is_in_group("copy_extend"):
		$"Bullet Control".CurrentCharge = $"Bullet Control".MaxCharge	# Max copy charge if colliding with copy charger
		body.queue_free()	# Remove body
	
	elif !is_dead:	# If colliding with anything else eg. enemy, bullet, die (don't allow dying while respawning)
		lives -= 1	# Subtract one life
		$PlayerAnimation.play("death")	# Play death animation (placeholder blank)
		is_dead = true	# Set is_dead variable to true, to lock control
		yield(get_tree().create_timer(0.5), "timeout")	# Wait half a second
		if lives >= 1:	# When player still has lives
			position.x = 160	# Reset player position (temporarily the Player node position defaults, change later)
			position.y = 120
			$PlayerAnimation.play("default")	# Return to default animation
			is_dead = false	# Change is_dead to false to regain control
		else:	# Game over routine
			get_tree().change_scene("res://Assets/Scenes/Test Scenes/Game Over.tscn")
	
