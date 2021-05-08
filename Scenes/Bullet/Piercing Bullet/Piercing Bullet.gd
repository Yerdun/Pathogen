extends Area2D


export var speed = 900 # the speed at which the bullet will travel

func _physics_process(delta):
	position += Vector2.RIGHT * speed * delta # go right

func _on_Bullet_body_entered(body):
	emit_signal("bulletContact") # can be listened to for enemy destruction?
