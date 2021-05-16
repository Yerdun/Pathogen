extends Node

# to make them loop in Godot, each song has been cut into two .ogg files

export (AudioStream) var intro # the intro section of the song
export (AudioStream) var loop # the looping section of the song

# they are being made into export variables in order to make this scene reusable

# Called when the node enters the scene tree for the first time.
func _ready():
	# assign the stream players their sound files
	$Intro.set_stream(intro) 
	$Loop.set_stream(loop)
	$Intro.play() # and instantly play the intro

# Fullscreen handler is in music handler since it exists in every scene
func _process(delta):
		if Input.is_action_just_pressed("fullscreen"):
			OS.set_window_fullscreen(!OS.window_fullscreen)	
 

# when the intro finishes, the loop section instantly plays
func _on_Intro_finished():
	$Loop.play()
# and it loops on its own thanks to the built-in settings
