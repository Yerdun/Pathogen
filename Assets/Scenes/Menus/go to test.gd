extends Button


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_focus()	# Focus on button for controller users


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_TestLevelButton_pressed() -> void:
	$"Click Noise".play()
	get_tree().change_scene("res://Assets/Scenes/Level/Level.tscn")
