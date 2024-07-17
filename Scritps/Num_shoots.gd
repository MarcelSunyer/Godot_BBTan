extends Node2D
@export var num_balls := 1

func _process(delta):
	var ball = get_node("Balon")
	# Duplica el nodo Ball
	if ball.position.y >=660:
		for i in range(num_balls):
			var ball_instance = ball.duplicate()
			add_child(ball_instance)
			ball_instance.position.x +=10 * delta
 # Cambia la posición según sea necesari
