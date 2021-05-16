extends Area2D

export var default_standard_speed = 300
export var default_focus_speed = 140

var standard_speed = default_standard_speed	# Standard speed
var focus_speed = default_focus_speed	# Speed while focused (slow mode)
export var lives = 3	# Amount of player lives
var is_dead = false		# Variable used to store death status (if dead, disallow doing anything)
var can_die = true		# Similar to is_dead, but only controls mercy frames

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
		
	if Input.is_action_pressed("godmode"):	# Press C for godmode
		if can_die:	# Activate godmode when C is pressed when you are able to die
			can_die = false
			$PlayerAnimation.play("respawned")
		elif !can_die:	# If it's already enabled, disable it
			can_die = true
			$PlayerAnimation.play("default")

func _on_Player_body_entered(body):
	if body.is_in_group("life_extend"):
		lives += 1	# Add one life if colliding with extend
		$"Bullet Control/Copy Success".play()
		body.queue_free()	# Remove body
	
	elif body.is_in_group("copy_extend"):
		$"Bullet Control".CurrentCharge = $"Bullet Control".MaxCharge	# Max copy charge if colliding with copy charger
		$"Bullet Control/Copy Ready".play()
		body.queue_free()	# Remove body
	
	elif !is_dead and can_die:	# If colliding with anything else eg. enemy, bullet, die (don't allow dying while respawning)
		lives -= 1	# Subtract one life
		$PlayerAnimation.play("death")	# Play death animation
		$"Death Sound".play() # Play death sound
		is_dead = true	# Set is_dead variable to true, to lock control
		can_die = false	# Set can_die to false, to give the player some invincibility frames on respawn
		yield(get_tree().create_timer(0.5), "timeout")	# Wait half a second
		
		if lives >= 1:	# When player still has lives
			position = Vector2(80,300)	# Reset player position
			$PlayerAnimation.play("respawned")	# Show respawn animation (blinking player)
			is_dead = false	# Change is_dead to false to regain control
			yield(get_tree().create_timer(3), "timeout")	# Give the player three seconds of mercy
			can_die = true	# Allow the player to die again
			$PlayerAnimation.play("default")	# Return to default animation
		
		elif $"../Wave Manager".loopCounter > 0:	# Victory routine
			get_tree().change_scene("res://Assets/Scenes/Menus/Victory.tscn")

			
		else:	# Game over routine
			get_tree().change_scene("res://Assets/Scenes/Menus/Game Over.tscn")
