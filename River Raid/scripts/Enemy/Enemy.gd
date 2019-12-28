tool
extends Area2D

signal enemy_destroyed

export var points: int = 0
export var is_static: bool = false
export var distance_to_player: float = 500
export (String, "right", "left") var choose_direction setget set_direction
export var speed: int = 100
export var exlosion_number: int = 10

var start_direction: int
var screen_size: Vector2

onready var start_position: Vector2 = position

onready var hud := get_tree().get_root().get_node("GameManager/HUD")
onready var player := get_tree().get_root().get_node("GameManager/Player")
onready var game_manager := get_tree().get_root().get_node("GameManager")

func _ready() -> void:
	on_ready()
		
func on_ready():
	screen_size = get_viewport_rect().size
	show()
	connect("enemy_destroyed", hud, "_on_score_changed")
	game_manager.connect("reset", self, "_on_game_reseted")

func _process(delta: float) -> void:
	if not Engine.editor_hint:
		if !is_static && is_player_in_range():
			on_process(delta)
	
func on_process(delta: float) -> void:
	vehicle_action()
	
func vehicle_action() -> void:
	position.x += start_direction * get_process_delta_time() * speed

func _on_Enemy_area_entered(area):
	var area_name = area.get_name()
	if area_name == "Projectile" || area_name == "Player":
		destroy_enemy()

func destroy_enemy() -> void:
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	print("enemy_destroyed; points: %s" % points)
	emit_signal("enemy_destroyed", points)
	ExplosionBuilder.explode(position,$Sprite.get_rect().end, exlosion_number)
	get_node("Explosion").play()


func _on_game_reseted():
	position = start_position
	show()
	$CollisionShape2D.set_deferred("disabled", false)
	
func set_direction(new_direction) -> void:
	choose_direction = new_direction
	if choose_direction == "right":
		start_direction = 1
		scale.x = 1
	else:
		start_direction = -1
		scale.x = -1

func is_player_in_range() -> bool:
	var player_position: Vector2 = player.get_global_transform().get_origin()
	var my_position: Vector2 = get_global_transform().get_origin()
	var current_distance: float = (player_position - my_position).length() 
	return current_distance <= distance_to_player && !player.get_node("CollisionPolygon2D").disabled