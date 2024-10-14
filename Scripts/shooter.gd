extends Node2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile_scene = preload("res://Scenes/projectile.tscn")
@onready var cooldown_timer = $Cooldown

@export var max_shoots = 5
var current_shots = 0
var balls = []  # Lista global de bolas disparadas

func _process(delta):
	if Input.is_action_just_pressed("Left_click"):
		if get_global_mouse_position().y <= 750:
			cooldown_timer.start()

func shoot():
	var instance = projectile_scene.instantiate()
	instance.spawnPos = global_position  # Asignar la posición donde aparece el disparo
	main.add_child(instance)  # Añadirlo a la escena principal
	
	# Agregar la bola a la lista global
	balls.append(instance)

func _on_cooldown_timeout():
	if current_shots < max_shoots:
		shoot()
		current_shots += 1
