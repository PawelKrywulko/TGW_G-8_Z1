extends Node

export (PackedScene) var Player
export (PackedScene) var Projectile

var player = null
var projectile = null

func _ready():
	player = Player.instance()
	add_child(player)

func _process(delta):
	if Input.is_action_pressed("ui_select") && can_shoot():
		projectile = Projectile.instance()
		projectile.position = player.position
		add_child(projectile)

func can_shoot():
	return get_node_or_null("Projectile") == null