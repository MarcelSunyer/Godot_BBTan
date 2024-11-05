extends Node2D

@export var max_bloques = 5
@export var espacio_entre_bloques = 100  # Espacio horizontal entre bloques
@onready var block_scene = preload("res://Scenes/Bloques.tscn")
@onready var shooter_node = get_parent().get_node("shooter")

var bloques = []  # Array para almacenar los bloques instanciados

func _ready():

	# Crear y organizar los bloques en fila
	for i in range(max_bloques):
		var block_instance = block_scene.instantiate()
		add_child(block_instance)
		
		# Posicionar el bloque en fila
		block_instance.position = Vector2(i * espacio_entre_bloques, 0)
		
		# Añadir el bloque al array
		bloques.append(block_instance)

func _process(delta):
		check_canshoot_status()
func check_canshoot_status():
	if shooter_node.has_moved:
		print("Se puede disparar")
	else:
		print("No se puede disparar")
