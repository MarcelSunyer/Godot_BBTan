extends RigidBody2D

var numero: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("move") # Replace with function body.
	

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mouse_click_left = Input.is_action_just_pressed("left_click")
	
	if mouse_click_left:
		set_linear_velocity(Vector2(100,-600))
		
	var mouse_click_right = Input.is_action_just_pressed("right_click")
	
	if mouse_click_right:
		linear_velocity = Vector2(-100,-600)

