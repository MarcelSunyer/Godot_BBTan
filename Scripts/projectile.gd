extends CharacterBody2D

@export var speed = 700
@export var reset_layer = 4  # Capa en la que se destruirá el proyectil

var dir: float
var spawnPos: Vector2
var spawnRot: float
var vel: Vector2

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

		# Imprimir información para depurar la capa del objeto colisionado
		print("Colisión con capa: ", collider.collision_layer)

		# Destruir si la capa coincide
		if collider.collision_layer == reset_layer:
			queue_free()
		else:
			vel = vel.bounce(collision_info.get_normal())
