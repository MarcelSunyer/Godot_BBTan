extends Node2D

@export var max_bloques = 5
@export var espacio_entre_bloques = 100  # Espacio horizontal entre bloques
@export var distancia_bajada = 100  # Distancia que los bloques bajan cada ronda
@onready var block_scene = preload("res://Scenes/Bloques.tscn")
@onready var start_round = get_parent().get_node("shooter")

var posiciones_ocupadas = []
var bloques = []  # Array para almacenar los bloques instanciados

func _ready():
	crear_fila_bloques()

func _process(delta):
	# Chequear constantemente si se puede iniciar una nueva ronda
	check_start_round()

func crear_fila_bloques():
	posiciones_ocupadas.clear()  # Reiniciar las posiciones ocupadas cada ronda

	for i in range(max_bloques):
		# Generar un bloque solo si la probabilidad es 65% o menor
		if randf() <= 0.65:
			var block_instance = block_scene.instantiate()
			add_child(block_instance)

			# Posición única para cada bloque, evitando posiciones anteriores
			var posicion_x = i * espacio_entre_bloques
			while posicion_x in posiciones_ocupadas:
				posicion_x += espacio_entre_bloques

			block_instance.position = Vector2(posicion_x, 0)
			posiciones_ocupadas.append(posicion_x)  # Guardar la posición usada
			bloques.append(block_instance)

func bajar_bloques():
	# Mover cada bloque hacia abajo
	for bloque in bloques:
		bloque.position.y += distancia_bajada

func check_start_round():
	# Verificar si `start_round.can_create_blocks` es `true` para iniciar la ronda
	if start_round.can_create_blocks:
		bajar_y_generar_bloques()
		# Restablecer `can_create_blocks` para la próxima ronda
		start_round.can_create_blocks = false
		
func bajar_y_generar_bloques():
	bajar_bloques()  # Baja los bloques actuales
	crear_fila_bloques()  # Genera una nueva fila al inicio de la ronda
