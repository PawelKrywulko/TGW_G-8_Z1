tool
extends "res://scripts/BasicEnemy.gd"

export var shell_scene: PackedScene
export var firerate: float 
onready var shot_cooldown: float
onready var collision = $GroundChecker
var elapsed_time: float = 0

func on_process(delta: float) -> void:
	if collision.get_overlapping_areas().size() > 0:
		.on_process(delta)
	else:
		elapsed_time += delta
		if shot_cooldown < elapsed_time:
			shot_cooldown = elapsed_time + firerate
			Shoot()

func Shoot() -> void:
		var shell = shell_scene.instance()
		add_child(shell)
		shell.set_position($Spawner.position)
		shell.set_flying_time(firerate)
		shell.set_target($ShotSpot.position)
