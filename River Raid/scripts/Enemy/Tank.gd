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
	if $Area2D.get_overlapping_areas().size() == 0:
		elapsed_time += get_process_delta_time()
		if shot_cooldown < elapsed_time:
			shot_cooldown = elapsed_time + firerate
			if elapsed_time > 100:
				elapsed_time = 0
			Shoot()
	else:
		.vehicle_action()

func Shoot() -> void:
		var shell = shell_scene.instance()
		add_child(shell)
		shell.set_position($Spawner.position)
		shell.set_flying_time(firerate)
		shell.set_target($ShotSpot.position)

func destroy_enemy() -> void:
	.destroy_enemy()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)

func _on_game_reseted():
	._on_game_reseted()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
