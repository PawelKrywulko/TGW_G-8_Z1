extends Area2D

signal enemy_destroyed

export (int) var points = 20

onready var hud
onready var game_manager

func _ready():
	show()
	hud = get_node("../HUD")
	connect("enemy_destroyed", hud, "_on_score_changed")
	game_manager = get_node("../../GameManager")
	if is_instance_valid(game_manager):
		game_manager.connect("reset", self, "_on_game_reseted")

func _on_Enemy_area_entered(area):
	var area_name = area.get_name()
	if area_name == "Projectile":
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		print("enemy_destroyed; points: %s" % points)
		emit_signal("enemy_destroyed", points)

func _on_game_reseted():
	show()
	$CollisionShape2D.set_deferred("disabled", false)