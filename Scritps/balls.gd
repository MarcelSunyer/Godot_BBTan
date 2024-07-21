extends CharacterBody2D

var ball_speed = Vector2()

# Definir la posición límite donde la bola debe desaparecer
var limit_position = 50

func _physics_process(delta):
	# Mover la bola
	var collision_info = move_and_collide(ball_speed * delta)
	if collision_info:
		ball_speed = ball_speed.bounce(collision_info.get_normal())
	print_debug(position)
	# Verificar si la bola ha alcanzado la posición límite
	if position.y >= limit_position:
		queue_free()  # Eliminar la bola de la escena
