extends Node2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile_scene = preload("res://Scenes/projectile.tscn")
@onready var cooldown_timer = $Cooldown

@export var max_shoots = 5
var current_shots = 0
var balls: Array = []
var start = true

func _process(delta):
	if start ==true:
		if Input.is_action_just_pressed("Left_click"):
			start = false
			if get_global_mouse_position().y <= 750 and cooldown_timer.is_stopped():
				cooldown_timer.start()
	else:
		print("The ball is currently moving")
	
	if balls.is_empty()==true:
		current_shots = 0
		print("The ball can be shooted")

func shoot():
	if current_shots < max_shoots:
		var instance = projectile_scene.instantiate()
		instance.spawnPos = global_position
		instance.spawnRot = rotation  # Asignamos la rotación
		instance.main_node = self  # Pasamos la referencia al nodo principal
		main.add_child(instance)
		balls.append(instance)  # Añadimos el proyectil a la lista
		current_shots += 1

func _on_cooldown_timeout():
	shoot()
