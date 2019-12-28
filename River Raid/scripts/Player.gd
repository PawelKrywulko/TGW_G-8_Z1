extends Area2D

signal player_destroyed
signal out_of_fuel
signal out_of_lives
signal lives_left
signal fuel_left

export var Projectile: PackedScene
export var base_speed: float = 500
export var fuel_capacity: float = 34
export var refueling_speed: float = 0.025
export var base_lives: int = 3
export var fuel_decreaser: float = 1
export var exlosion_number: int = 5

var projectile = null
var speed: float
var fuel_amount: float = fuel_capacity
var lives: int = base_lives
var screen_size: Vector2
var can_fly: bool = false
var is_any_button_pressed: bool = false
var is_refueling: bool = false

var debugging: bool = false #true tylko jeśli debugujemy

func _ready() -> void:
	$CollisionPolygon2D.set_deferred("disabled", true)
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
	refueling()

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
		$Engine.set_pitch_scale(1)
		fuel_decreaser = 1
		speed = base_speed
		velocity.y -= 1
		if Input.is_action_pressed("ui_up"):
			speed = base_speed * 1.5
			$Engine.set_pitch_scale(1.5)
			fuel_decreaser = 1.5
		if Input.is_action_pressed("ui_down"):
			speed = base_speed * 0.7
			$Engine.set_pitch_scale(0.7)
			fuel_decreaser = 0.7
			
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			
		position += velocity * delta

func fuel_monitor() -> void:
	if fuel_amount <= 0:
		emit_signal("player_destroyed")
	elif fuel_amount < 5:
		if !$LowFuel.playing:
			$LowFuel.play()
			
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
	if area_name.begins_with("FuelTank"):
		print("refueling_started")
		$FuelTimer.stop()
		is_refueling = true
	elif area_name == "Projectile":
		return
	else:
		print("player_destroyed")
		emit_signal("player_destroyed")

func _on_Player_area_exited(area) -> void:
	var area_name: String = area.get_name()
	if area_name.begins_with("FuelTank"):
		print("refueling_stopped")
		$FuelTimer.start()
		is_refueling = false

func refueling() -> void:
	if is_refueling && fuel_amount <= fuel_capacity:
		if !$Refueling.playing:
			$Refueling.play()
		fuel_amount += refueling_speed
		if fuel_amount >= fuel_capacity:
			$Refueled.play()

func _on_FuelTimer_timeout() -> void:
	if fuel_amount > 0:
		fuel_amount -= fuel_decreaser

func _on_Player_player_destroyed() -> void:
	reset()
	$DeathSound.play()
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
	$LowFuel.stop()
	$Engine.stop()
	ExplosionBuilder.explode(position,$Sprite.get_rect().end, exlosion_number)
	
	if(lives > 0):
		lives -= 1
		emit_signal("lives_left", lives)
	if(lives == 0):
		emit_signal("out_of_lives")

func wait_for_pressing_key() -> void:
	while true:
		yield(get_tree(),"idle_frame")
		if Input.is_action_pressed("interact"):
			$CollisionPolygon2D.set_deferred("disabled", false)
			$Engine.play()
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

func _on_HUD_bonus_score_reached():
	lives += 1
