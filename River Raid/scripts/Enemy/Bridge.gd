extends Area2D

signal bridge_destroyed
signal bridge_destroyed_hud

export var points: int = 500

onready var hud := get_tree().get_root().get_node("GameManager/HUD")
onready var game_manager := get_tree().get_root().get_node("GameManager")
export var exlosion_number: int = 25
onready var destroy_area := $Area2D
var destroy_enemies_behind: bool = false
var areas

func _ready():
	show()
	connect("bridge_destroyed_hud", hud, "_on_score_changed")
	connect("bridge_destroyed", hud, "_on_bridge_destroyed")
	connect("bridge_destroyed", game_manager, "_on_bridge_destroyed")
	game_manager.connect("kill_enemies_behind", self, "_on_game_reseted")
	
func _process(delta):
	if areas == null:
		areas = $Area2D.get_overlapping_areas()

func _on_Bridge_area_entered(area):
	var area_name: String = area.get_name()
	if area_name.begins_with("Tank"):
		connect("bridge_destroyed", area, "destroy_enemy")
	if area_name == "Projectile" || area_name == "Player":
		destroy_enemies_behind = true
		hide()
		ExplosionBuilder.explode(get_global_transform().get_origin(),$Sprite.get_rect().end, exlosion_number)
		$CollisionShape2D.set_deferred("disabled", true)
		print("bridge_destroyed; points: %s" % points)
		emit_signal("bridge_destroyed_hud", points)
		emit_signal("bridge_destroyed")

func _on_Bridge_area_exited(area):
	var area_name = area.get_name()
	if area_name.begins_with("Tank"):
		disconnect("bridge_destroyed", area, "destroy_enemy")

func _on_game_reseted():
	if destroy_enemies_behind:
		for area in areas:
			if is_instance_valid(area):
				if area.name == "Player" || area.get_parent().is_in_group("Level") || area.name.begins_with("Bridge"):
						pass
				else:
					area.hide()
					area.queue_free()
		queue_free()
