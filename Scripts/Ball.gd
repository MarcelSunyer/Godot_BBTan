extends CharacterBody2D

@export var speed = 250.0
var move_ball = false

# Define la capa de colisión del suelo (por ejemplo, layer 1)
@export var suelo_layer = 1

func _input(event):
	if event is InputEventMouseButton and event.pressed and not move_ball:
		move_ball = true
		# Obtén la posición del ratón en el escenario
		var mouse_position = get_global_mouse_position()
		# Calcula la dirección hacia el ratón y normalízala
		var direction = (mouse_position - global_position).normalized()
		# Ajusta la velocidad para que la pelota se mueva hacia el ratón
		velocity = direction * speed

func _process(delta):
	if move_ball:
		var collision_info = move_and_collide(velocity * delta)
		if collision_info:
			# Obtén el nodo con el que colisionó la pelota
			var collider = collision_info.get_collider() as Node2D
			
			# Verifica si el collider es un nodo válido y tiene la capa de colisión correcta
			if collider and collider.collision_layer & (1 << suelo_layer) != 0:
				# Detén el movimiento si colisiona con el suelo
				velocity = Vector2.ZERO
				move_ball = false
			else:
				# Rebota si no es el suelo
				velocity = velocity.bounce(collision_info.get_normal())
