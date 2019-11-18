extends Area2D

export var speed = 400
var velocity

func _ready():
	add_to_group("projectile")
	velocity = Vector2(0, -1)

func _process(delta):
	position += velocity * speed * delta

func _on_Visibility_screen_exited():
	queue_free()
