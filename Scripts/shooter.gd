extends Node2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile_scene = preload("res://Scenes/projectile.tscn")
@onready var cooldown_timer = $Cooldown

var diana: Node2D = null  # Referencia a la diana creada
var target_position: Vector2  # Posición hacia donde apuntarán los disparos

@export var max_shoots = 1
var current_shots = 0
var balls: Array = []
var has_moved = false  # Control para mover solo una vez por ronda

func _process(delta):
	if Input.is_action_just_pressed("Left_click"):
		target_position = get_global_mouse_position()  # Guardamos la posición del clic
		
		if cooldown_timer.is_stopped():
			cooldown_timer.start()

	# Permitir reiniciar el conteo de disparos si ya no hay proyectiles activos
	if balls.is_empty() and Input.is_action_just_pressed("Left_click"):
		reset_shots()
		start_new_round()  # Reiniciar la ronda al resetear los disparos

func reset_shots():
	current_shots = 0  # Reiniciar el conteo de disparos
	max_shoots += 1 

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
		shoot()

func move_to_ball_position(position: Vector2):
	if not has_moved:  # Solo mover si no se ha movido en esta ronda
		global_position.x = position.x  # Mueve el personaje a la posición de la bola destruida
		has_moved = true  # Marcar que ya se ha movido en esta ronda

func start_new_round():
	has_moved = false  # Permitir movimiento en la nueva ronda
