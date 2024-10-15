extends Node2D

@onready var main = get_tree().get_root().get_node("main")
var diana = load("res://Scenes/Diana.tscn")
var newDiana
@onready var projectile_scene = preload("res://Scenes/projectile.tscn")
@onready var cooldown_timer = $Cooldown

var first_click_pos: Vector2  # Almacena la posición del primer clic
var shooting: bool = false  # Indica si ya hemos hecho el primer disparo

@export var max_shoots = 5
var current_shots = 0
var balls: Array = []
var start = true
var canshoot = false

func _process(delta):
	if Input.is_action_just_pressed("Left_click"):
		createDiana(get_global_mouse_position())
		print(newDiana.position)
		if get_global_mouse_position().y <= 750 and cooldown_timer.is_stopped():
			cooldown_timer.start()
	
	if balls.is_empty()==true && Input.is_action_just_pressed("Left_click"):
		current_shots = 0
		createDiana(get_global_mouse_position())
		canshoot = true

func shoot():
	if current_shots < max_shoots:
		if not shooting:  # Solo capturamos la posición en el primer disparo
			first_click_pos = get_global_mouse_position()
			shooting = true  # Marcamos que ya estamos disparando

		var instance = projectile_scene.instantiate()
		instance.spawnPos = global_position
		instance.spawnRot = rotation  # Asignamos la rotación inicial
		instance.main_node = self  # Pasamos la referencia al nodo principal

		# Calculamos la velocidad hacia la posición del primer clic
		instance.vel = (first_click_pos - global_position).normalized() * instance.speed

		main.add_child(instance)
		balls.append(instance)  # Añadimos el proyectil a la lista
		current_shots += 1

func _on_cooldown_timeout():
	if canshoot:
		shoot()

func createDiana(mousePosition: Vector2):
	newDiana = diana.instantiate()
	newDiana.position = mousePosition
	add_child(newDiana)

	
