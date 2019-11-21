extends Area2D

signal enemy_destroyed

onready var hud
export (int) var points = 20

func _ready():
	hud = get_node("../HUD")
	print(hud.name)
	connect("enemy_destroyed", hud,"_on_score_change")

func _on_Enemy_area_entered(area):
	var area_name = area.get_name()
	if area_name == "Projectile":
		queue_free()
		print("enemy_destroyed; points: %s" % points)
		emit_signal("enemy_destroyed", points)