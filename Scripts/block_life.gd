extends StaticBody2D

@export var vida = 3  # Vida inicial del bloque
@onready var vida_label = $Label

func _ready():
	vida_label.text = str(vida)  # Mostrar la vida inicial en el Label

func reduce_vida():
	vida -= 1
	vida_label.text = str(vida)  # Actualizar la vida en el Label

	if vida <= 0:
		queue_free()  # Elimina el bloque si la vida llega a 0
