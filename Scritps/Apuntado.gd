extends CharacterBody2D

var speed = 300


func _physics_process(delta):
	# Get the mouse position in the world
	var mouse_position = get_global_mouse_position()
	
	# Calculate the direction from the bullet to the mouse
	var direction = (mouse_position - global_position).normalized()
	
	# Move the bullet in the direction of the mouse
	velocity = direction * speed * delta
	
	move_and_slide()

	# Rotate the sprite to point in the direction of movement (optional)
	rotation = direction.angle()
