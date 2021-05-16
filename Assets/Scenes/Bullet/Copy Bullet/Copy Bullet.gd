extends Area2D

export var speed = 900 # the speed at which the bullet will travel

signal copied_rapidfire
signal copied_widebeam
signal copied_piercing
signal copied_speedup

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
			"speedup":
				emit_signal("copied_speedup")
			_:
				print("Default message!")
				
	if body.is_in_group("enemies"):	# if hitting an enemy
		queue_free() # destroy bullet on collision


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	# Remove after exiting screen
