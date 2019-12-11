extends Area2D

signal bridge_destroyed

export var points: int = 100

onready var hud
onready var game_manager

func _ready():
	show()
	hud = get_node("../HUD")
	connect("bridge_destroyed", hud, "_on_score_changed")
	game_manager = get_node("../../GameManager")
	if is_instance_valid(game_manager):
		game_manager.connect("reset", self, "_on_game_reseted")

func _on_Bridge_area_entered(area):
	var area_name = area.get_name()
	if area_name == "Tank":
		points += 50
	if area_name == "Projectile":
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		print("bridge_destroyed; points: %s" % points)
		emit_signal("bridge_destroyed", points)

func _on_Bridge_area_exited(area):
	var area_name = area.get_name()
	if area_name == "Tank":
		points -= 50

func _on_game_reseted():
	show()
	$CollisionShape2D.set_deferred("disabled", false)