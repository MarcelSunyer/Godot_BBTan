extends Sprite2D

var position_clicked

func _ready():
	rotation = 190
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position_clicked = get_viewport().get_mouse_position().x
	position_clicked /= 150
	
	if position_clicked <= 0.6:
		position_clicked = 0.71
	if position_clicked >= 2.4:
		position_clicked = 2.39
		
	rotation = position_clicked
