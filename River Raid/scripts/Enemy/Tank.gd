tool
extends "res://scripts/Enemy/Enemy.gd"

<<<<<<< HEAD
export var shell_scene: PackedScene
export var firerate: float 
onready var shot_cooldown: float
var elapsed_time: float = 0

func vehicle_action() -> void:
	if $Area2D.get_overlapping_areas().size() == 0:
		elapsed_time += get_process_delta_time()
		if shot_cooldown < elapsed_time:
			shot_cooldown = elapsed_time + firerate
			if elapsed_time > 100:
				elapsed_time = 0
			Shoot()
			speed = 0

func Shoot() -> void:
		var shell = shell_scene.instance()
		add_child(shell)
		shell.set_position($Spawner.position)
		shell.set_flying_time(firerate)
		shell.set_target($ShotSpot.position)
=======
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
>>>>>>> e83b1cd4f9498d2b5f73fab4f52998e2ced25276
