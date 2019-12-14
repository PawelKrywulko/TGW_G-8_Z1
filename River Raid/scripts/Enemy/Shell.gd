extends Node2D

export var explosion_scene : PackedScene
var start_vector: Vector2
var target_vector: Vector2
var flying_time: float = 10
var time_elapsed: float = 0

func _process(delta):
	move(delta)

func move(delta) -> void:
	time_elapsed += delta
	var t = time_elapsed / flying_time
	if t > 1:
		var explosion = explosion_scene.instance()
		get_parent().add_child(explosion)
		explosion.position = position
		queue_free()
	else:
		position = start_vector.linear_interpolate(target_vector,t)

func set_flying_time(time: float) -> void:
	flying_time = time

func set_position(pos: Vector2) -> void:
	position = pos
	start_vector = pos

func set_target(new_target:Vector2) -> void:
	target_vector = new_target
