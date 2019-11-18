extends Area2D

signal hit

export (int) var speed = 600
var screen_size
var velocity

func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, 960)

func _process(delta):
	move(delta)

func move(delta):
	velocity = Vector2()
	velocity.y -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	velocity = velocity * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
