extends Node2D

@export var max_bloques = 5
@export var espacio_entre_bloques = 100
@export var distancia_bajada = 100
@onready var block_scene = preload("res://Scenes/Bloques.tscn")
@onready var start_round = get_parent().get_node("shooter")

var posiciones_ocupadas = []
var bloques = []

func _ready():
	crear_fila_bloques()

func _process(delta):
	check_start_round()

func crear_fila_bloques():
	posiciones_ocupadas.clear() 

	for i in range(max_bloques):
		if randf() <= 0.65:
			var block_instance = block_scene.instantiate()
			add_child(block_instance)

			var posicion_x = i * espacio_entre_bloques
			while posicion_x in posiciones_ocupadas:
				posicion_x += espacio_entre_bloques

			block_instance.position = Vector2(posicion_x, 0)
			
			posiciones_ocupadas.append(posicion_x)  
			bloques.append(block_instance)  


func bajar_bloques():

	for bloque in bloques:
		bloque.position.y += distancia_bajada

func check_start_round():
	if start_round.can_create_blocks:
		bajar_y_generar_bloques()
		start_round.can_create_blocks = false
		
func bajar_y_generar_bloques():
	bajar_bloques()
	crear_fila_bloques()
