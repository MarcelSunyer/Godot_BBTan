extends StaticBody2D

@export var vida = 3  # Vida inicial del bloque
@onready var vida_label = $Label
var exit_game = false

func _ready():
	vida_label.text = str(vida)  # Mostrar la vida inicial en el Label

func _process(delta):
	# Verificar la posición en y solo si `exit_game` es false
	if not exit_game and global_position.y >= 700:
		exit_game = true
		print("El bloque ha alcanzado o superado la posición Y = 700")
		# Puedes agregar aquí cualquier acción adicional si es necesario

func reduce_vida():
	vida -= 1
	vida_label.text = str(vida)  # Actualizar la vida en el Label

	if vida <= 0:
		queue_free()  # Elimina el bloque si la vida llega a 0
