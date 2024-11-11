extends Node2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile_scene = preload("res://Scenes/projectile.tscn")
@onready var cooldown_timer = $Cooldown

var diana: Node2D = null  # Referencia a la diana creada
var target_position: Vector2  # Posición hacia donde apuntarán los disparos

@export var max_shoots = 1
var current_shots = 0
var balls: Array = []
var can_moved = false  # Control para mover solo una vez por ronda
var can_create_blocks = false  # Control para permitir la creación de bloques
var round_started = false  # Flag para indicar si la ronda ha comenzado
var cant_shoot = false

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	if(mouse_position.y <=	775 ):
		cant_shoot = false
	else:
		cant_shoot = true
	if not cant_shoot:	
		if Input.is_action_just_pressed("Left_click") and not round_started:
		# Iniciar la ronda con el clic y establecer la posición de la diana
			target_position = get_global_mouse_position()
		
			round_started = true  # Marcar que la ronda ha comenzado
			if cooldown_timer.is_stopped():
				cooldown_timer.start()

	# Lógica para el fin de ronda al destruir todas las bolas y mover solo si ya se disparó
		if balls.is_empty() and can_moved:
			end_session()

func reset_shots():
	current_shots = 0  # Reiniciar el conteo de disparos

func shoot():

	if round_started and current_shots < max_shoots:
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
	if not can_moved:  # Solo mover si no se ha movido en esta ronda
		global_position.x = position.x  # Mueve el personaje a la posición de la bola destruida
		can_moved = true  # Marcar que ya se ha movido en esta ronda

func start_new_round():
	can_moved = false  # Resetear para permitir movimiento en la nueva ronda
	current_shots = 0  # Reiniciar el conteo de disparos
	max_shoots += 1  # Aumentar el número máximo de disparos cada ronda
	round_started = false  # Esperar clic del jugador para comenzar la ronda

func end_session():
	can_moved = false  # Permitir movimiento en la siguiente ronda
	can_create_blocks = true  # Permitir creación de bloques en la nueva ronda

	# Notificar a los bloques para bajar y crear una nueva fila
	var blocks_node = get_parent().get_node("creació_blocks")
	if blocks_node:
		blocks_node.bajar_y_generar_bloques()

	# Mueve al jugador a la posición de la primera bola destruida
	if balls.size() > 0:
		move_to_ball_position(balls[0].global_position)

	start_new_round()
