tool
extends "res://scripts/Enemy/Enemy.gd"

func vehicle_action() -> void:
	.vehicle_action()
	if $RayCast2D.is_colliding():
		transform.x *= -1
		start_direction *= -1