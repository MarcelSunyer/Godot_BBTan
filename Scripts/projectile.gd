extends CharacterBody2D

@export var speed = 700
@export var reset_layer = 4  
@export var block_layer = "block_layer"

var spawnPos: Vector2
var spawnRot: float
var vel: Vector2

var main_node
var moved = false 

func _ready():
	global_position = spawnPos 
	global_rotation = spawnRot 

func _physics_process(delta):
	var collision_info = move_and_collide(vel * delta) 

	if collision_info:
		var collider = collision_info.get_collider()

		if collider.is_in_group("bloque"):
			collider.reduce_vida()
			
		if collider.collision_layer == reset_layer:
			remove_from_balls()
			queue_free()
		else:
			vel = vel.bounce(collision_info.get_normal())

func remove_from_balls():
	if main_node and self in main_node.balls:
		main_node.balls.erase(self) 
		if not moved: 
			main_node.move_to_ball_position(global_position)
			moved = true
