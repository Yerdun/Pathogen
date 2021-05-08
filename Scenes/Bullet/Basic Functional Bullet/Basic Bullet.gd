extends RigidBody2D



export var speed = 900 # the speed at which the bullet will travel


# Called when the node enters the scene tree for the first time.
func _ready():
	# go right
	linear_velocity = Vector2.RIGHT * speed


func _on_Bullet_body_entered(body):
	emit_signal("bulletContact") # can be listened to for enemy destruction?
	queue_free() #destroy bullet on enemy contact
