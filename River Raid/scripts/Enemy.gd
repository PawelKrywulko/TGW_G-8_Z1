tool

extends Area2D

signal enemy_destroyed

export var points: int = 20
enum DIR {LEFT, RIGHT}
export(DIR) var direction
var startDirection : int
export var speed: int = 100

onready var hud := get_node("../HUD")
onready var game_manager = get_node("../../GameManager")
onready var raycast = get_node("RayCast2D")

func _ready() -> void:
	if direction == DIR.RIGHT:
		startDirection = 1
	else:
		startDirection = -1
	on_ready()

func on_ready() -> void:
	if not Engine.editor_hint:
		show()
		connect("enemy_destroyed", hud, "_on_score_changed")
		if is_instance_valid(game_manager):
			game_manager.connect("reset", self, "_on_game_reseted")

func _process(delta: float):
	if Engine.editor_hint:
		if direction == DIR.RIGHT:
			scale.x = abs(scale.x) * 1
		else:
			scale.x = abs(scale.x) * -1
	if not Engine.editor_hint:
		on_process(delta)

func on_process(delta: float) -> void:
		if raycast.is_colliding():
			transform.x *= -1
			startDirection *= -1
		print(position.x)
		position.x += startDirection * delta * speed
		print("a teraz: " + str(position.x))

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