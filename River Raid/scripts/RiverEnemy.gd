tool

extends "res://scripts/BasicEnemy.gd"

onready var raycast = $RayCast2D

func on_process(delta: float) -> void:
	if raycast.is_colliding():
		transform.x *= -1
		start_direction *= -1
	else:
		.on_process(delta)
