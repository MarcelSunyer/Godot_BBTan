extends CharacterBody2D

var ball_speed = Vector2(200,200)
var collision_info

func _physics_process(delta):
	collision_info = move_and_collide(ball_speed*delta)
	if collision_info:
		ball_speed = ball_speed.bounce(collision_info.get_normal())
	
