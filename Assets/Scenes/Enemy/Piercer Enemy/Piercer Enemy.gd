extends "res://Assets/Scenes/Enemy/Basic Enemy/Enemy.gd"


# Declare member variables here. Examples:
export var charge_speed = 660
var _waitingToCharge = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Hitbox".shape.extents = Vector2(32,22)	# Hitbox better fits sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# the piercer enemy uses the physics engine to enter. it rapidly comes in and
	# slows to a stop. 
	# when the enemy stops moving left...
	if linear_velocity.x >= 0 and !_waitingToCharge:
		# ensure that it stops moving
		applied_force = Vector2.ZERO
		linear_velocity.x = 0
		# and start waiting to charge
		_waitingToCharge = true
		$"Charge Timer".start()

func _on_Charge_Timer_timeout(): # when the charge timer runs out...
	# chaaaaaarge!
	$"Charge Sound".play()
	linear_velocity.x = -1 * charge_speed # the -1 makes it go left


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	# Unload the enemy if it exits the screen. Specific to piercers since they're the only ones that go offscreen regularly, and I'd rather not risk a shooter or chaser disappear.
