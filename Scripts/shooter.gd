extends Node2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile_scene = preload("res://Scenes/projectile.tscn")
@onready var cooldown_timer = $Cooldown
@onready var aim = $aim

@export var max_shoots = 5
var current_shots = 0

	
func _process(delta):
	if Input.is_action_just_pressed("Left_click"):
		if get_global_mouse_position().y <= 750:
			cooldown_timer.start()	

func shoot():
		var instance = projectile_scene.instantiate()
		instance.spawnPos = global_position
		main.add_child.call_deferred(instance)

func _on_cooldown_timeout():
	if(current_shots <= max_shoots):
		shoot()
		current_shots += 1
