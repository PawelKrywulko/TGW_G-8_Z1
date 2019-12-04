tool
extends Area2D

signal enemy_destroyed

export var points: int = 20
export (String, "right", "left") var choose_direction setget set_direction
export var speed: int = 100

var start_direction: int

onready var hud := get_node("../HUD")
onready var game_manager := get_node("../../GameManager")
onready var raycast := get_node("RayCast2D")

func _ready() -> void:
	set_direction(choose_direction)
	on_ready()
		
func on_ready():
	show()
	connect("enemy_destroyed", hud, "_on_score_changed")
	if is_instance_valid(game_manager):
		game_manager.connect("reset", self, "_on_game_reseted")

func _process(delta: float) -> void:
	if Engine.editor_hint:
		return
	on_process(delta)
	
func on_process(delta: float) -> void:
	if raycast.is_colliding():
		transform.x *= -1
		start_direction *= -1
	
	position.x += start_direction * delta * speed

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
	
func set_direction(new_direction) -> void:
	choose_direction = new_direction
	if choose_direction == "right":
		choose_direction = "right"
		start_direction = 1
		self.scale.x = 1
	else:
		choose_direction = "left"
		start_direction = -1
		self.scale.x = -1