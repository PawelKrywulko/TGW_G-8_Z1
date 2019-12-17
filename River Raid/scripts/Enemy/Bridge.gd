extends Area2D

signal bridge_destroyed
signal bridge_destroyed_hud

export var points: int = 500

onready var hud := get_tree().get_root().get_node("GameManager/HUD")
onready var game_manager := get_tree().get_root().get_node("GameManager")

func _ready():
	show()
	connect("bridge_destroyed_hud", hud, "_on_score_changed")
	game_manager.connect("reset", self, "_on_game_reseted")

func _on_Bridge_area_entered(area):
	var area_name: String = area.get_name()
	if area_name.begins_with("Tank"):
		connect("bridge_destroyed", area, "destroy_enemy")
	if area_name == "Projectile" || area_name == "Player":
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		print("bridge_destroyed; points: %s" % points)
		emit_signal("bridge_destroyed_hud", points)
		emit_signal("bridge_destroyed")

func _on_Bridge_area_exited(area):
	var area_name = area.get_name()
	if area_name.begins_with("Tank"):
		disconnect("bridge_destroyed", area, "destroy_enemy")

func _on_game_reseted():
	show()
	$CollisionShape2D.set_deferred("disabled", false)