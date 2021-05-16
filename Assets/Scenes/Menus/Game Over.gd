extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.grab_focus()	# Focus on button for controller users


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$"Menu Click".play()
	$Sprite.queue_free()
	$ColorRect.queue_free()
	$Button.queue_free()
	$Title/TestLevelButton.grab_focus()
