extends CharacterBody2D

var ball_speed = Vector2()
var position_clicked = Vector2()

var y_limit = 800

var collision_info

var left_click = false
var right_click = false
var can_move = false
var moving = false

var burst_count = 5  # Número de bolas en la ráfaga
var burst_interval = 0.1 

func _physics_process(delta):
	left_click = Input.is_action_just_pressed("Left_click")
	position_clicked = get_global_mouse_position()
	if position.y >= 660:
		moving = false
		can_move = false

	if !moving: 
		if left_click:
			if position_clicked.y < y_limit:
				var direction = (position_clicked - global_position).normalized()
				ball_speed = direction * 700
				can_move = true
				moving =true
				start_burst()
				shoot_ball(direction)
			
	
	if can_move:
		collision_info = move_and_collide(ball_speed * delta)
		if collision_info:
			ball_speed = ball_speed.bounce(collision_info.get_normal())

func start_burst():
	var direction = (position_clicked - global_position).normalized()
	ball_speed = direction * 700
	# Inicia la ráfaga de disparos
	await get_tree().create_timer(burst_interval).timeout
	for i in range(burst_count):
		if not can_move:
			break
		shoot_ball(direction)
		await get_tree().create_timer(burst_interval).timeout
		
func shoot_ball(direction):
	# Crear una nueva instancia de la bola aquí (asegúrate de tener una escena de bola preparada)
	var ball_instance = preload("res://Scenes/Ball.tscn").instantiate()  # Reemplaza con la ruta correcta a tu escena de bola
	ball_instance.position = Vector2(0,0)
	print_debug(ball_instance.position)
	ball_instance.ball_speed = direction * 700
	get_parent().add_child(ball_instance)
