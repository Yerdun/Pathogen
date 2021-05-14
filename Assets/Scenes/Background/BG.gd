extends Control

func _ready():
	$AnimationPlayer.get_animation("normal").set_loop(true)
	$AnimationPlayer.play("normal")
