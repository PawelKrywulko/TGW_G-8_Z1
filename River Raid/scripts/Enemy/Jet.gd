tool
extends "res://scripts/Enemy/Enemy.gd"

func vehicle_action() -> void:
	.vehicle_action()
	if position.x > screen_size.x:
		position.x = 0
	elif position.x < 0:
		position.x = screen_size.x