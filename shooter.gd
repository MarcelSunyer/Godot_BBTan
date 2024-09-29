extends Node2D

@onready var main = get_tree().get_root().get_node("main")
@onready var projectile_scene = preload("res://projectile.tscn")

@export var max_shoots = 5
var current_shots = 0

# Shoots a projectile
func shoot():
	var instance = projectile_scene.instantiate()
	instance.dir = rotation  # Set the projectile's direction based on the current rotation

	instance.spawnPos = global_position  # Set to the global position of the current node
	main.add_child.call_deferred(instance)

func _on_cooldown_timeout():
	if(current_shots < max_shoots):
		shoot()
		current_shots += 1
