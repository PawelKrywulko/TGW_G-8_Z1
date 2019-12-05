tool
extends "res://scripts/BasicEnemy.gd"

export var firerate: float
onready var collision = $Area2D

func on_process(delta: float) -> void:
	if collision.get_overlapping_areas().size() > 0:
		.on_process(delta)
	else:
		Shoot()

func Shoot() -> void:
	print("Shot")
	