tool
extends "res://scripts/Enemy/Enemy.gd"

onready var bridge

func on_ready() -> void:
	.on_ready()
	bridge = get_node("../Bridge")
	bridge.connect("bridge_destroyed", self, "_on_bridge_destroyed")

func vehicle_action() -> void:
	if $Area2D.get_overlapping_areas().size() == 0:
		speed = 0
		
func _on_bridge_destroyed(points: int) -> void:
	destroy_enemy()