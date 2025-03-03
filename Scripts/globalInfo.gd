extends Node

var totalBalls = 1


func _physics_process(delta):
	print_debug(totalBalls)
	
func SetBalls(balls):
	totalBalls = balls
func GetBalls():
	return totalBalls
