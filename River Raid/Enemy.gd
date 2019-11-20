extends Area2D

signal enemy_destroyed

export (int) var points = 20

func _on_Enemy_area_entered(area):
	var area_name = area.get_name()
	if area_name == "Projectile":
		queue_free()
		print("enemy_destroyed; points: %s" % points)
		emit_signal("enemy_destroyed", points)