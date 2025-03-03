extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	


func _on_button_pressed() -> void:
	OS.shell_open("https://github.com/MarcelSunyer")


func _on_button_2_pressed() -> void:
	OS.shell_open("https://www.linkedin.com/in/marcel-sunyer-28910a133/")


func _on_button_3_pressed() -> void:
	OS.shell_open("https://marcelsunyer.github.io/Marcel.github.io/")


func _on_button_4_pressed() -> void:
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
