extends Area2D

signal player_destroyed
signal out_of_fuel
signal out_of_lives
signal lives_left
signal fuel_left

export (PackedScene) var Projectile
export (float) var base_speed = 500
export (int) var fuel_capacity = 64
export (int) var base_lives = 3

var projectile = null
var speed
var fuel_amount = fuel_capacity
var lives = base_lives
var screen_size
var velocity
var can_fly = false
var is_any_button_pressed = false
	
func _process(delta):
	move(delta)
	shoot(position)
	fuel_monitor()
	live_monitor()

func move(delta):
	if can_fly && is_any_button_pressed:
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

func fuel_monitor():
	emit_signal("fuel_left", fuel_amount)
func live_monitor():
	emit_signal("lives_left", lives)

func shoot(pos):
	if Input.is_action_pressed("ui_select") && can_shoot():
		projectile = Projectile.instance()
		projectile.position = pos
		get_tree().get_root().add_child(projectile)

func can_shoot():
	return get_tree().get_root().get_node_or_null("Projectile") == null && is_any_button_pressed

func _on_Player_area_entered(area):
	var area_name = area.get_name()
	if area_name == "FuelTank":
		print("fuel restored!")
		fuel_amount = fuel_capacity
	elif area_name == "Projectile":
		return
	else:
		print("player_destroyed")
		reset()
		if lives == 1:
			_on_Player_player_destroyed()
		else:
			emit_signal("player_destroyed")

func _on_FuelTimer_timeout():
	if fuel_amount > 0:
		fuel_amount -= 1
	if fuel_amount == 0:
		print("out_of_fuel")
		emit_signal("out_of_fuel")
		print("player_destroyed")
		emit_signal("player_destroyed")

func _on_Player_player_destroyed():
	hide()
	reset()
	if(lives > 0):
		lives -= 1
		emit_signal("lives_left", lives)
	if(lives == 0):
		emit_signal("out_of_lives")

func wait_for_pressing_key():
	while true:
		yield(get_tree(),"idle_frame")
		if Input.is_action_pressed("interact"): #jakiś przycisk którego nie będziemy przyciskać :P
			break

func _on_ready_to_go():
	yield(wait_for_pressing_key(), "completed")
	prepare_to_fly()

func prepare_to_fly():
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, 960)
	can_fly = true
	is_any_button_pressed = true
	$FuelTimer.start()
	
func reset():
	$FuelTimer.stop()
	can_fly = false
	is_any_button_pressed = false
	fuel_amount = fuel_capacity

func _on_GameManager_reset():
	reset()

func _on_Player_out_of_lives():
	#na razie tylko tak
	yield(get_tree().create_timer(3.0), "timeout")
	lives = base_lives
