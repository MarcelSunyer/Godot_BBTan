extends CharacterBody2D

@export var speed = 700
@export var reset_layer = 4  # Capa en la que se destruirá el proyectil

var spawnPos: Vector2
var spawnRot: float
var vel: Vector2

var main_node  # Referencia al nodo principal que gestiona los disparos

func _ready():
	global_position = spawnPos  # Colocar en la posición de inicio
	global_rotation = spawnRot  # Aplicar la rotación inicial

	# No recalculamos la dirección aquí, ya que `vel` debe venir asignada
	# desde el nodo principal (por consistencia).

func _physics_process(delta):
	var collision_info = move_and_collide(vel * delta)  # Mover el proyectil

	if collision_info:
		var collider = collision_info.get_collider()
		if collider.collision_layer == reset_layer:
			remove_from_balls()  # Eliminar de la lista del nodo principal
			queue_free()
		else:
			vel = vel.bounce(collision_info.get_normal())  # Rebote en colisión

func remove_from_balls():
	if main_node and self in main_node.balls:
		main_node.balls.erase(self)  # Eliminar de la lista de proyectiles
