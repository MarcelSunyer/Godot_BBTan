extends Node2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile_scene = preload("res://Scenes/projectile.tscn")
@onready var cooldown_timer = $Cooldown

var diana_scene = preload("res://Scenes/Diana.tscn")
var diana: Node2D = null  # Referencia a la diana creada
var target_position: Vector2  # Posición hacia donde apuntarán los disparos

@export var max_shoots = 5
var current_shots = 0
var balls: Array = []
var canshoot = false

func _process(delta):
	if Input.is_action_just_pressed("Left_click"):
		target_position = get_global_mouse_position()  # Guardamos la posición del clic
		create_diana(target_position)  # Creamos la diana en esa posición

		if cooldown_timer.is_stopped():
			cooldown_timer.start()
		canshoot = true  # Permitimos disparar

	# Permitir reiniciar el conteo de disparos si ya no hay proyectiles activos
	if balls.is_empty() and Input.is_action_just_pressed("Left_click"):
		reset_shots()

func reset_shots():
	current_shots = 0  # Reiniciar el conteo de disparos

func shoot():
	if current_shots < max_shoots:
		var instance = projectile_scene.instantiate()
		instance.spawnPos = global_position  # Posición inicial del proyectil
		instance.main_node = self  # Pasar la referencia al nodo principal

		# Calcular la dirección hacia la diana seleccionada
		var direction = (target_position - global_position).normalized()
		instance.vel = direction * instance.speed  # Asignar velocidad

		main.add_child(instance)  # Añadir el proyectil a la escena
		balls.append(instance)  # Guardar en la lista de proyectiles
		current_shots += 1

func _on_cooldown_timeout():
	if canshoot:
		shoot()

func create_diana(position: Vector2):
	# Si ya hay una diana, la eliminamos antes de crear una nueva
	if diana != null:
		diana.queue_free()

	diana = diana_scene.instantiate() as Node2D
	diana.position = position
	add_child(diana)
