extends RigidBody2D

export var maxHP = 8 # the amount of hp the enemy has at spawn
var currentHP # the enemy's current hp
export(String, "none", "rapidfire", "widebeam", "piercing", "speedup") var copyAbility	# The enemy's ability that can be copied
export(String, "none", "life", "copy") var itemToDrop	# Variable that stores what sort of item the enemy will drop

# Called when the node enters the scene tree for the first time.
func _ready():
	currentHP = maxHP # give the enemy full HP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_tryDying()

func _tryDying(): # called every frame to see if the enemy is dead
	if currentHP <= 0: #when the enemy's HP is at or below zero:
		if itemToDrop != "none":
			drop()	# drop an item
		get_tree().call_group("bullet_control", "chargeCopyBullet")	# Call bullet control group to call the bullet charging function
		queue_free() # destroy the enemy

func takeDamage(var amount): # this function can be called by a bullet to inflict damage
	# amount variable is the amount of damage taken
	$"Enemy Impact".play()
	currentHP = max(0, currentHP - amount) # this line caps hp loss at 0

func GetCopyAbility():
	return copyAbility	# When hit by a copy bullet, the enemy will return its ability name


func drop():
	var dropToLoad	# Variable used to store the packed scene that the enemy will drop
	if itemToDrop == "life":
		dropToLoad = preload("res://Assets/Scenes/Items/LifeExtend.tscn")
	elif itemToDrop == "copy":
		dropToLoad = preload("res://Assets/Scenes/Items/CopyBulletExtend.tscn")
	var drop = dropToLoad.instance()	# Variable stores an instance of the loaded scene
	drop.position = position	# Set the drop's position to the enemy's position
	get_parent().add_child(drop)	# Add the item to the scene tree
