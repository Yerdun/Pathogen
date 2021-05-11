extends Area2D

export var speed = 900 # the speed at which the bullet will travel

signal copied_rapidfire
signal copied_widebeam
signal copied_piercing

func _ready():
	pass

func _physics_process(delta):
	position += Vector2.RIGHT * speed * delta # go right


func _on_Copy_Bullet_body_entered(body):
	if body.has_method("GetCopyAbility"): # check if what was hit has a copy ability
		match body.GetCopyAbility(): # and emit a signal depending on what ability
			"rapidfire":
				emit_signal("copied_rapidfire")
			"widebeam":
				emit_signal("copied_widebeam")
			"piercing":
				emit_signal("copied_piercing")
			_:
				print("Default message!")
	queue_free() # destroy bullet on enemy contact
