tool
extends "res://scripts/Enemy/Enemy.gd"

export var shell_scene: PackedScene
export var firerate: float 
onready var shot_cooldown: float
var elapsed_time: float = 0

func on_ready() -> void:
	.on_ready()
	points = 250

func vehicle_action() -> void:
	var areas = $Area2D.get_overlapping_areas()
	for area in areas:
		if area.name == "Bridge":
			.vehicle_action()

func destroy_enemy() -> void:
	.destroy_enemy()
	queue_free()
