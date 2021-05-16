extends Node



func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):	# When the fullscreen button is pressed
		OS.set_window_fullscreen(!OS.window_fullscreen)		# Toggle fullscreen
