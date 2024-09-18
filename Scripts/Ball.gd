extends CharacterBody2D

@export var speed = 250.0
var move_ball = false

# Define los vértices del triángulo
@export var vertex1 = Vector2(0, 300) # Izquierda
@export var vertex2 = Vector2(400, 0) # Arriba
@export var vertex3 = Vector2(800, 300) # Derecha

# Define la capa de colisión del suelo (por ejemplo, layer 2)
@export var suelo_layer = 2

# Función para verificar si el punto está dentro del triángulo
func is_point_in_triangle(point: Vector2, a: Vector2, b: Vector2, c: Vector2) -> bool:
	var v0 = c - a
	var v1 = b - a
	var v2 = point - a

	var dot00 = v0.dot(v0)
	var dot01 = v0.dot(v1)
	var dot02 = v2.dot(v0)
	var dot11 = v1.dot(v1)
	var dot12 = v2.dot(v1)

	var invDenom = 1 / (dot00 * dot11 - dot01 * dot01)
	var u = (dot11 * dot02 - dot01 * dot12) * invDenom
	var v = (dot00 * dot12 - dot01 * dot02) * invDenom

	return (u >= 0) and (v >= 0) and (u + v < 1)

func _input(event):
	if event is InputEventMouseButton and event.pressed and not move_ball:
		var mouse_position = get_global_mouse_position()
		
		# Verifica si el clic está dentro del triángulo
		if is_point_in_triangle(mouse_position, vertex1, vertex2, vertex3):
			move_ball = true
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
			
			# Verifica si el collider es un nodo válido y está en la capa de colisión deseada
			if collider and (collider.collision_layer & (1 << (suelo_layer - 1))) != 0:
				# Detén el movimiento si colisiona con el suelo
				velocity = Vector2.ZERO
				move_ball = false
			else:
				# Rebota si no es el suelo
				velocity = velocity.bounce(collision_info.get_normal())
