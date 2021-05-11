extends Area2D

export var standard_speed = 300	# Standard speed
export var focus_speed = 140	# Speed while focused (slow mode)
export var lives = 3			# Amount of player lives

func _ready():
	pass # Currently unneeded, included as a stub.

func _process(delta):
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
	
	if is_focused == true:
		speed = focus_speed
		$FocusAnimation.play("focused") # Placeholder animation just containing 1 frame showing hitbox
	elif is_focused == false:
		speed = standard_speed
		$FocusAnimation.play("default") # Placeholder blank animation
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta

func _on_Player_body_entered(body):
#	Pseudocode
#	if the item that entered is a 1up
#		add one life
#	else if the item that entered is a bomb up (i guess copybullet in this case?)
#		max out the copy meter
#	else
#		subtract one life (possible through takedamage function)
#		clear the player
#		reset player position on the map
	if body.is_in_group("life_extend"):
		lives += 1	# Add one life if colliding with extend
		body.queue_free()	# Remove body
	elif body.is_in_group("copy_extend"):
		$"Bullet Control".CurrentCharge = $"Bullet Control".MaxCharge	# Max copy charge if colliding with copy charger
		body.queue_free()	# Remove body
	
	print("Object in player body") # Stub console output for hit detection
