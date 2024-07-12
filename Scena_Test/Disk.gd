extends CharacterBody2D

var ball_speed
var position_clicked
var collision_info
var right_click = false
var can_move = false
var can_save_position = true

func _physics_process(delta):
	right_click = Input.is_action_just_released("Right_click")	
	position_clicked = get_viewport().get_mouse_position().x
	position_clicked -= 230
	print_debug(position_clicked)
	
	if right_click:
		can_save_position = false
		ball_speed = Vector2(position_clicked,-300)
		can_move = true
		
	if can_move:
		collision_info = move_and_collide(ball_speed*delta)
		if collision_info:
			ball_speed = ball_speed.bounce(collision_info.get_normal())
	
