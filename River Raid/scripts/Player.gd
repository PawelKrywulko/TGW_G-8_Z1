extends Area2D

signal player_destroyed
signal out_of_fuel
signal out_of_lives
signal lives_left
signal fuel_left

export var Projectile: PackedScene
export var base_speed: float = 500
export var fuel_capacity: int = 64
export var base_lives: int = 3

var projectile = null
var speed: float
var fuel_amount: int = fuel_capacity
var lives: int = base_lives
var screen_size: Vector2
var can_fly: bool = false
var is_any_button_pressed: bool = false

var debugging: bool = false #true tylko jeśli debugujemy

func _ready() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	screen_size = get_viewport_rect().size
	#służy tylko do debugowania żeby samolot leciał
	if debugging:
		can_fly = true
		is_any_button_pressed = true
	################################################

func _physics_process(delta: float) -> void:
	move(delta)
	turn(delta)
	shoot(position)
	fuel_monitor()
	live_monitor()

func turn(delta: float) -> void:
	if can_fly && is_any_button_pressed:
		var velocity: Vector2 = Vector2()
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			
		if velocity.length() > 0:
			velocity = velocity.normalized() * base_speed
		
		position += velocity * delta
		position.x = clamp(position.x, 0, screen_size.x)

func move(delta: float) -> void:
	if can_fly && is_any_button_pressed:
		var velocity: Vector2 = Vector2()
		speed = base_speed
		velocity.y -= 1
		if Input.is_action_pressed("ui_up"):
			speed = base_speed * 1.5
		if Input.is_action_pressed("ui_down"):
			speed = base_speed * 0.7
			
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			
		position += velocity * delta

func fuel_monitor() -> void:
	emit_signal("fuel_left", fuel_amount)
func live_monitor() -> void:
	emit_signal("lives_left", lives)

func shoot(pos: Vector2) -> void:
	if Input.is_action_pressed("ui_select") && can_shoot():
		projectile = Projectile.instance()
		projectile.position = pos
		get_tree().get_root().add_child(projectile)

func can_shoot() -> bool:
	return get_tree().get_root().get_node_or_null("Projectile") == null && is_any_button_pressed

func _on_Player_area_entered(area) -> void:
	var area_name: String = area.get_name()
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

func _on_FuelTimer_timeout() -> void:
	if fuel_amount > 0:
		fuel_amount -= 1
	if fuel_amount == 0:
		print("out_of_fuel")
		emit_signal("out_of_fuel")
		print("player_destroyed")
		emit_signal("player_destroyed")

func _on_Player_player_destroyed() -> void:
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	if(lives > 0):
		lives -= 1
		emit_signal("lives_left", lives)
	if(lives == 0):
		emit_signal("out_of_lives")

func wait_for_pressing_key() -> void:
	while true:
		yield(get_tree(),"idle_frame")
		if Input.is_action_pressed("interact"):
			$CollisionShape2D.set_deferred("disabled", false)
			break

func _on_ready_to_go() -> void:
	yield(wait_for_pressing_key(), "completed")
	prepare_to_fly()

func prepare_to_fly() -> void:
	can_fly = true
	is_any_button_pressed = true
	$FuelTimer.start()
	
func reset() -> void:
	$FuelTimer.stop()
	can_fly = false
	is_any_button_pressed = false
	fuel_amount = fuel_capacity

func _on_GameManager_reset() -> void:
	reset()

func _on_Player_out_of_lives() -> void:
	#na razie tylko tak
	lives = base_lives
