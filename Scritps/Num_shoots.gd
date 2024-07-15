extends Node2D


var ball_scene = preload("res://Scena_Test/ball.tscn")
var right_click = false

# Referencia al Timer
@onready var spawn_timer = $SpawnTimer
@onready var ball = $Balon

func _ready():
	
	# Configura el tiempo de espera del temporizador (en segundos)
	spawn_timer.wait_time = 2.0  # Cambia el tiempo según sea necesario
	# Conecta la señal "timeout" del temporizador a una función que instanciará el balón
	spawn_timer.connect("timeout", Callable(self, "_on_SpawnTimer_timeout"))
	# Inicia el temporizador
	spawn_timer.start()
	
func _on_SpawnTimer_timeout():
	# Duplica el nodo Ball
	var ball_instance = ball.duplicate(5)
	# Añadir la instancia del balón a la escena como hijo de Node2D
	add_child(ball_instance)
 # Cambia la posición según sea necesario

	# Reiniciar el temporizador si quieres instanciar balones repetidamente
	spawn_timer.start()
