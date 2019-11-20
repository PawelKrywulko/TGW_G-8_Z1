extends Area2D

signal player_refueled
signal fuel_tank_destroyed

func _on_FuelTank_area_entered(area):
	var area_name = area.get_name()
	if area_name == "Player":
		print("player_refueled")
		emit_signal("player_refueled")
	if area_name == "Projectile":
		queue_free()
		print("fuel_tank_destroyed")
		emit_signal("fuel_tank_destroyed", 50)
