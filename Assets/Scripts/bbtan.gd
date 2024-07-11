extends CharacterBody2D

var numero: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Move") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direccion * 200
	move_and_slide()
