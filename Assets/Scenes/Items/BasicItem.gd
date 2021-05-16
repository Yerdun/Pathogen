extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var timeToCollect = 15	# How long the item stays on the field

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = clamp(position.x, 32, 768)	# Make sure the item stays within screen boundaries
	position.y = clamp(position.y, 32, 568)
	$Timer.start(timeToCollect - 5)	# Subtract 5 from user defined time since it will be blinking once it hits 5 seconds


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$AnimatedSprite.play("default")	# Play default animation, which should be blinking
	yield(get_tree().create_timer(5), "timeout")	# Wait for another five seconds
	queue_free()	# Delete the item when the timer runs out
