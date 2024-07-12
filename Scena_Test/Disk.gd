extends CharacterBody2D

var ball_speed = Vector2(200,200)
var collision_info
var right_click = false
var can_move = false

func _physics_process(delta):
	right_click = Input.is_action_just_released("Right_click")
		
	if right_click:
		can_move = true
		
	if can_move:
		collision_info = move_and_collide(ball_speed*delta)
		if collision_info:
			ball_speed = ball_speed.bounce(collision_info.get_normal())
	
