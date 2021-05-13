extends Node


# Declare member variables here. Examples:
# var a = 2
export (AudioStream) var intro
export (AudioStream) var loop


# Called when the node enters the scene tree for the first time.
func _ready():
	$Intro.set_stream(intro)
	$Loop.set_stream(loop)
	$Intro.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Intro_finished():
	$Loop.play()
