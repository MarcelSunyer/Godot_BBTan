extends StaticBody2D

var vida = 1 
@onready var vida_label = $Label
var exit_game = false

func _ready():
	vida = globalInfo.GetBalls();
	vida_label.text = str(vida)
	
	
	
	
func _process(delta):
	if not exit_game and global_position.y >= 700:
		exit_game = true

func reduce_vida():
	vida -= 1
	vida_label.text = str(vida)

	if vida <= 0:
		queue_free()  
		
func levelUp():
	vida += 1
	vida_label.text = str(vida)
