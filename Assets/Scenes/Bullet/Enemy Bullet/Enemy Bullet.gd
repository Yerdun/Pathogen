extends Area2D


# Declare member variables here. Examples:
export var speed = 800 # speed the bullet travels

export (Vector2) var direction = Vector2.LEFT # the direction the bullet travels
# this vector should be a unit vector

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += direction * speed * delta