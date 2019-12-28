extends Area2D

export var speed = 400
var velocity

func _ready():
	velocity = Vector2(0, -1)

func _process(delta):
	position += velocity * speed * delta

func _on_Visibility_screen_exited():
	queue_free()

func _on_Projectile_area_entered(area):
	if(area.get_name() != "Player"):
		ExplosionBuilder.explode(position,$Sprite.get_rect().end)
		queue_free()