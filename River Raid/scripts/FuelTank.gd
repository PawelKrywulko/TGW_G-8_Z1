extends Area2D

signal fuel_tank_destroyed

export var points: int = 80

onready var hud := get_tree().get_root().get_node("GameManager/HUD")
onready var game_manager := get_tree().get_root().get_node("GameManager")
export var exlosion_number: int = 15

func _ready():
	show()
	connect("fuel_tank_destroyed", hud, "_on_score_changed")
	game_manager.connect("reset", self, "_on_game_reseted")

func _on_FuelTank_area_entered(area):
	var area_name: String = area.get_name()
	if area_name == "Projectile":
		hide()
		ExplosionBuilder.explode(get_global_transform().get_origin(),$Sprite.get_rect().end, exlosion_number)
		$CollisionShape2D.set_deferred("disabled", true)
		print("fuel_tank_destroyed; points: %s" % points)
		emit_signal("fuel_tank_destroyed", points)

func _on_game_reseted():
	show()
	$CollisionShape2D.set_deferred("disabled", false)
