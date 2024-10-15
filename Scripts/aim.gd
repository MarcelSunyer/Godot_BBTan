extends Sprite2D

func _process(delta):
	# Obtén la posición del mouse en el espacio global
	var mouse_position = get_global_mouse_position()

	look_at(mouse_position)

		
