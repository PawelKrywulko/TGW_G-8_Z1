tool

extends "res://scripts/BasicEnemy.gd"

func on_process(delta: float) -> void:
	.on_process(delta)
	if position.x > screen_size.x:
		position.x = 0
	elif position.x < 0:
		position.x = screen_size.x
