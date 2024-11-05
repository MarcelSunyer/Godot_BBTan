extends Node2D

@export var max_bloques = 5
@export var espacio_entre_bloques = 100  # Espacio horizontal entre bloques
@export var distancia_bajada = 50  # Distancia que los bloques bajan cada ronda
@onready var block_scene = preload("res://Scenes/Bloques.tscn")
@onready var start_round = get_parent().get_node("shooter")

var bloques = []  # Array para almacenar los bloques instanciados

func _ready():
	crear_fila_bloques()

func _process(delta):
	# Chequear constantemente si se puede iniciar una nueva ronda
	check_start_round()

func crear_fila_bloques():
	# Crear y organizar los bloques en fila
	for i in range(max_bloques):
		var block_instance = block_scene.instantiate()
		add_child(block_instance)
		
		# Posicionar el bloque en fila
		block_instance.position = Vector2(i * espacio_entre_bloques, 0)
		
		# Añadir el bloque al array
		bloques.append(block_instance)

func bajar_bloques():
	# Mover cada bloque hacia abajo
	for bloque in bloques:
		bloque.position.y += distancia_bajada

func check_start_round():
	# Verificar si `start_round.has_moved` es `true` para iniciar la ronda
	if start_round.can_create_blocks:
		
		bajar_bloques()
		crear_fila_bloques()
		
		# Restablecer `has_moved` para la próxima ronda
		start_round.can_create_blocks = false
