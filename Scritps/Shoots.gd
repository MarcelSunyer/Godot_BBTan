extends CharacterBody2D

var ball_speed = Vector2()
var position_clicked = Vector2()

var y_limit = 800

var left_click = false
var can_move = false
var moving = false

@export var balls = 5  # Número de bolas en la ráfaga
@export var interval_vall_spawn = 0.1 

var direction

func _physics_process(delta):
	left_click = Input.is_action_just_pressed("Left_click")
	position_clicked = get_global_mouse_position()
	if position.y >= 660:
		moving = false
		can_move = false

	if !moving: 
		if left_click:
			if position_clicked.y < y_limit:
				start_burst()
				can_move = true
				moving = true

func start_burst():
	direction = (position_clicked - global_position).normalized()
	ball_speed = direction * 700
	for i in range(balls):
		shoot_ball(direction)
		await get_tree().create_timer(interval_vall_spawn).timeout
		
func shoot_ball(direction):
	# Crear una nueva instancia de la bola aquí (asegúrate de tener una escena de bola preparada)
	var ball_instance = preload("res://Scenas/Ball.tscn").instantiate()  # Reemplaza con la ruta correcta a tu escena de bola
	ball_instance.position = Vector2(0,0)  # Posición local de la bola en el emisor
	ball_instance.ball_speed = direction * 700
	print_debug(ball_instance.position)
	
	# Ajustar la posición global de la bola
	ball_instance.global_position = global_position + ball_instance.position
	
	get_parent().add_child(ball_instance)
