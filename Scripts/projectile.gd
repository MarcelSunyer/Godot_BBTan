extends CharacterBody2D

@export var speed = 700
@export var reset_layer = 4  # Capa en la que se destruirá el proyectil

var dir: float
var spawnPos: Vector2
var spawnRot: float
var vel: Vector2

var main_node  # Aquí guardaremos la referencia al nodo que tiene 'balls'

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot

	# Calcular la velocidad inicial hacia el mouse
	var mouse_pos = get_global_mouse_position()
	vel = (mouse_pos - global_position).normalized() * speed
	vel = vel.rotated(dir)

func _physics_process(delta):
	var collision_info = move_and_collide(vel * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		# Destruir si la capa coincide
		if collider.collision_layer == reset_layer:
			remove_from_balls()  # Llamamos al método para eliminar de la lista
			queue_free()
		else:
			vel = vel.bounce(collision_info.get_normal())

func remove_from_balls():
	if main_node and self in main_node.balls:
		main_node.balls.erase(self)  # Eliminamos el proyectil de la lista
	var balls: Array = [] 
