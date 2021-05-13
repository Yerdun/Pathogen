extends Control

func _ready():
	$AnimationPlayer.play("normal")

func _on_AnimationPlayer_animation_finished(anim_name):
	_ready()
