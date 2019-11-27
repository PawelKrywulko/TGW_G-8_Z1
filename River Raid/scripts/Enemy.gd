extends Area2D

signal enemy_destroyed

export var points: int = 20
export var startDirection: int = 1 #1 = right ; -1 = left
export var speed: int = 100

onready var hud = get_node("../HUD")
onready var game_manager = get_node("../../GameManager")
onready var raycast = get_node("RayCast2D")

func _ready():
	show()
	connect("enemy_destroyed", hud, "_on_score_changed")
	if is_instance_valid(game_manager):
		game_manager.connect("reset", self, "_on_game_reseted")
		
func _process(delta):
	if raycast.is_colliding():
		transform.x *= -1
		startDirection *= -1
	
	position.x += startDirection * delta * speed


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