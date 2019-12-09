tool
extends "res://scripts/Enemy/Enemy.gd"

func vehicle_action() -> void:
	if $Area2D.get_overlapping_areas().size() == 0:
		speed = 0