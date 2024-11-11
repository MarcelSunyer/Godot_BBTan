extends Sprite2D

func _physics_process(delta):
	# Obtén la posición del mouse en el espacio global
	var mouse_position = get_global_mouse_position()
	if(mouse_position.y <775):
		look_at(mouse_position)

		
