extends Node2D

@export var max_bloques = 5
@export var espacio_entre_bloques = 100  # Espacio horizontal entre bloques
@onready var block_scene = preload("res://Scenes/Bloques.tscn")

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
