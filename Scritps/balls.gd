extends CharacterBody2D

var ball_speed = Vector2()

# Definir la posición límite donde la bola debe desaparecer
var limit_position = 50

func _physics_process(delta):
	# Mover la bola
	var collision_info = move_and_collide(ball_speed * delta)
	if collision_info:
		var body = collision_info.get_collider()
		if body is StaticBody2D and body.name == "Gloton":
			queue_free()
		ball_speed = ball_speed.bounce(collision_info.get_normal())
		

