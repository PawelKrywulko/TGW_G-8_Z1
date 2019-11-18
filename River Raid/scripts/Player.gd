extends Area2D

signal hit

export var speed = 400
var screen_size
var velocity

func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, 960)

func _process(delta):
	move(delta)

func move(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.frame = 0
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	animate(velocity)
	
func animate(velocity):
	if velocity.x != 0:
		$AnimatedSprite.animation = "turn"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
