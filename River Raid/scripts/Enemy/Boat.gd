tool
extends "res://scripts/Enemy/Enemy.gd"

func vehicle_action() -> void:
	if $RayCast2D.is_colliding():
		transform.x *= -1
		start_direction *= -1