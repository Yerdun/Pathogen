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

var type = null

const MOVE_SPEED = 420
onready var raycast = $RayCast2D

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("pathogens","set_player",self)
	
func _process(delta):
	ShootLoop()
	
func ShootLoop():
	if(Input.is_action_just_pressed("shoot")):
		var coll = raycast.get_collider()
		if raycast.is_colliding() and coll.has_method("kill"):
			coll.kill()

func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1	
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1	
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1		
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1	
	move_vec = move_vec.normalized()
	if type == 1:									#if set to type 1, stole ability giving 1.5 times speed
		move_and_collide(move_vec * MOVE_SPEED * delta * 2.5)
	else:
		move_and_collide(move_vec * MOVE_SPEED * delta)
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("get_ability"): #if use steal, if directed enemy is in pathogens, set to type 1
		var coll = raycast.get_collider()
		if raycast.is_colliding() and coll.has_method("kill"):
			if coll.is_in_group("pathogens"):
				change_Type()
			coll.kill()
	
func change_Type():
	type = 1
		

func kill():
	get_tree().reload_current_scene()		
	
>>>>>>> 73856d9 (Switched Player script from C# to GDScript)
