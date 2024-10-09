extends CharacterBody2D

@export var speed = 700
@export var reset_layer = 3

var dir : float
var spawnPos : Vector2
var spawnRot : float
var vel : Vector2

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	# Obtener la posición del mouse relativa al objeto y calcular la velocidad inicial
	var mouse_pos = get_global_mouse_position()
	vel = (mouse_pos - global_position).normalized() * speed
	vel = vel.rotated(dir)
	

func _physics_process(delta):
	var collision_info = move_and_collide(vel * delta)
	if collision_info:
		vel = vel.bounce(collision_info.get_normal())


func _on_area_2d_area_entered(area):
	if area.name == "Destroy":
		queue_free()		
