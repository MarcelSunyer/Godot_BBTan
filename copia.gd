extends Node2D

# Export para permitir ajustar la velocidad desde el editor
@export var speed = 0;

# Nodo para seguir
onready var target := $TargetNode  # Cambia este a tu nodo objetivo

# Variable para la instancia del seguidor
var follower_instance := null

func _ready():
	# Instanciar el seguidor
	var follower_scene = preload("res://Follower.tscn")
	follower_instance = follower_scene.instance()
	# Añadir el seguidor como hijo del padre de este nodo
	get_parent().add_child(follower_instance)
	follower_instance.position = position - Vector2(10, 10)  # Opcional: cambiar posición inicial

func _process(delta):
	# Mover el objeto principal
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	position += direction.normalized() * speed * delta

	# Hacer que el seguidor siga al objeto principal con un offset
	if follower_instance:
		var offset = Vector2(10, 10)  # Ajustar si es necesario
		follower_instance.position = position - offset
