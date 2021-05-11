<<<<<<< HEAD
<<<<<<< HEAD
extends Area2D

export var standard_speed = 300	# Standard speed
export var focus_speed = 140	# Speed while focused (slow mode)

func _ready():
	pass # Currently unneeded, included as a stub.

func _process(delta):
	var velocity = Vector2.ZERO # Movement velocity represented as a 2 dimensional vector
	var speed = standard_speed # Speed variable. initialised to standard speed
	var is_focused = false # Tracks whether or not player is focused
	#var player_animation = $PlayerAnimation # Method used to play and stop player animation
	#var focus_animation = $FocusAnimation # Method used to play and stop focusing animation

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
	print("Object in player body") # Stub console output for hit detection
=======
extends KinematicBody2D
=======
extends Area2D
>>>>>>> 15dd5e0 (Fixed Player.gd, moved Hitbox Test scene)

export var standard_speed = 300	# Standard speed
export var focus_speed = 140	# Speed while focused (slow mode)

func _ready():
	pass # Currently unneeded, included as a stub.

func _process(delta):
	var velocity = Vector2.ZERO # Movement velocity represented as a 2 dimensional vector
	var speed = standard_speed # Speed variable. initialised to standard speed
	var is_focused = false # Tracks whether or not player is focused
	#var player_animation = $PlayerAnimation # Method used to play and stop player animation
	#var focus_animation = $FocusAnimation # Method used to play and stop focusing animation

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

<<<<<<< HEAD
func kill():
	get_tree().reload_current_scene()		
	
>>>>>>> 73856d9 (Switched Player script from C# to GDScript)
=======
	position += velocity * delta

func _on_Player_body_entered(body):
	print("Object in player body") # Stub console output for hit detection
>>>>>>> 15dd5e0 (Fixed Player.gd, moved Hitbox Test scene)
