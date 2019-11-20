extends Area2D

signal player_destroyed
signal out_of_fuel
signal out_of_lives

export (PackedScene) var Projectile
export (float) var base_speed = 500
export (int) var fuel_capacity = 10
export (int) var lives = 3

var projectile = null
var fuel_amount
var speed
var screen_size
var velocity

func _ready():
	fuel_amount = fuel_capacity
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, 960)

func _process(delta):
	shoot(position)
	velocity = Vector2()
	speed = base_speed
	if Input.is_action_pressed("ui_right"):
		velocity.x += (1 * base_speed)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= (1 * base_speed)
	if Input.is_action_pressed("ui_up"):
		speed = base_speed * 2
	if Input.is_action_pressed("ui_down"):
		speed = base_speed / 2

	velocity.y -= (1 * speed)
	var pos = position + velocity * delta
	pos.x = clamp(pos.x, 0, screen_size.x)
	position = pos
	
func shoot(pos):
	if Input.is_action_pressed("ui_select") && can_shoot():
		projectile = Projectile.instance()
		projectile.position = pos
		get_tree().get_root().add_child(projectile)

func can_shoot():
	return get_tree().get_root().get_node_or_null("Projectile") == null

func _on_Player_area_entered(area):
	var area_name = area.get_name()
	if area_name == "FuelTank":
		print("fuel restored!")
		fuel_amount = fuel_capacity
	elif area_name == "Projectile":
		return
	else:
		print("player_destroyed")
		emit_signal("player_destroyed")
		hide()

func _on_FuelTimer_timeout():
	fuel_amount -= 1
	if fuel_amount == 0:
		print("out_of_fuel")
		emit_signal("out_of_fuel")
		print("player_destroyed")
		emit_signal("player_destroyed")
		hide()

func _on_Player_player_destroyed():
	lives -= 1
	if(lives == 0):
		emit_signal("out_of_lives")
