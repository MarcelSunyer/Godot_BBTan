extends CharacterBody2D

var ball_speed = Vector2()
var position_clicked = Vector2()

var y_limit = 800

var collision_info

var left_click = false
var right_click = false
var can_move = false
var moving = false


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
			
	
	if can_move:
		collision_info = move_and_collide(ball_speed * delta)
		if collision_info:
			ball_speed = ball_speed.bounce(collision_info.get_normal())
