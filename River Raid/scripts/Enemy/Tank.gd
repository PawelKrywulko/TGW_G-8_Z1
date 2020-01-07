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
	if areas.size() == 0:
		elapsed_time += get_process_delta_time()
		if shot_cooldown < elapsed_time:
			shot_cooldown = elapsed_time + firerate
			if elapsed_time > 100:
				elapsed_time = 0
			Shoot()
	else:
		var one_move = true
		for area in areas:
			if(area.name.begins_with("Player")):
				elapsed_time += get_process_delta_time()
				if shot_cooldown < elapsed_time:
					shot_cooldown = elapsed_time + firerate
					if elapsed_time > 100:
						elapsed_time = 0
					Shoot()
			else:
				if one_move:
					one_move = false
					.vehicle_action()

func Shoot() -> void:
	var shell = shell_scene.instance()
	add_child(shell)
	$Shoot.play()
	shell.set_position($Spawner.position)
	shell.set_flying_time(firerate)
	shell.set_target($ShotSpot.position)

func destroy_enemy() -> void:
	.destroy_enemy()
	queue_free()

