extends CharacterBody2D

@export var speed = 250.0

func _ready():
	velocity = Vector2(-200,-200).normalized() * speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
