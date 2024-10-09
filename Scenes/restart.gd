extends Area2D

# Esta función será callable y se encargará de destruir el Area2D
func destroy_area():
	queue_free()  # Destruir el área

func _ready():
	# Conectar la señal body_entered al método que queremos hacer callable
	connect("body_entered", Callable(self, "_on_area_entered"))
	
func _on_area_entered(body):
	# Verificamos si el cuerpo que entra es el CharacterBody2D
	if body is CharacterBody2D:
		print("Colisión con el CharacterBody2D detectada")
		
		# Destruir el Area2D
		queue_free()
