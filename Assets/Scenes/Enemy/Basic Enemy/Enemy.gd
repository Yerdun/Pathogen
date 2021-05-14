extends RigidBody2D

export var maxHP = 8 # the amount of hp the enemy has at spawn
var currentHP # the enemy's current hp
export(String, "none", "rapidfire", "widebeam", "piercing", "speedup") var copyAbility	# The enemy's ability that can be copied
export(String, "none", "life", "copy") var itemToDrop	# Variable that stores what sort of item the enemy will drop

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHP = maxHP # give the enemy full HP
	itemToDrop = "none"	# By default, enemies drop no items


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_tryDying()

func _tryDying(): # called every frame to see if the enemy is dead
	if currentHP <= 0: #when the enemy's HP is at or below zero:
		if itemToDrop == "life":
			owner.owner.add_child($"res://Assets/Scenes/Items/LifeExtend.tscn")
		elif itemToDrop == "copy":
			owner.owner.add_child($"res://Assets/Scenes/Items/CopyExtend.tscn")
		queue_free() # destroy the enemy

func takeDamage(var amount): # this function can be called by a bullet to inflict damage
	# amount variable is the amount of damage taken

	$"Enemy Impact".play()
	currentHP = max(0, currentHP - amount) # this line caps hp loss at 0

func GetCopyAbility():
	return copyAbility	# When hit by a copy bullet, the enemy will return its ability name
