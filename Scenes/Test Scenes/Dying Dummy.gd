extends RigidBody2D


# Declare member variables here. Examples:
export (int) var maxHP = 2 # the amount of hp the enemy has at spawn
var currentHP # the enemy's current hp

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHP = maxHP # give the enemy full HP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_tryDying()

func _tryDying(): # called every frame to see if the enemy is dead
	if currentHP <= 0: #when the enemy's HP is at or below zero:
		queue_free() # destroy the enemy

func takeDamage(var amount): # this function can be called by a bullet to inflict damage
	# amount variable is the amount of damage taken
	currentHP = max(0, currentHP - amount) # this line caps hp loss at 0

func getCopyAbility():
	return ""