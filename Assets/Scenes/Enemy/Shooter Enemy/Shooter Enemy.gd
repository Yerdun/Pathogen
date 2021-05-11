extends "res://Assets/Scenes/Enemy/Basic Enemy/Enemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Hitbox".shape.extents = Vector2(32,24)	# Hitbox better fits sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
