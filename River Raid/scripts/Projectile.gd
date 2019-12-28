extends Area2D

export var speed = 400
var velocity
export var exlosion_number: int = 3

func _ready():
	velocity = Vector2(0, -1)

func _process(delta):
	position += velocity * speed * delta

func _on_Visibility_screen_exited():
	queue_free()

func _on_Projectile_area_entered(area):
	if(area.get_name() != "Player"):
		get_tree().get_root().get_node("Projectile").hide()
		$CollisionShape2D.set_deferred("disabled", true)
		$Explosion.play()
		yield(get_tree().create_timer(0.56), "timeout")
		var end_y = $Sprite.get_rect().end.x * $Sprite.scale.x
		var end_x = $Sprite.get_rect().end.y * $Sprite.scale.y
		var vector_end = Vector2(end_x, end_y)
		ExplosionBuilder.explode(position,vector_end, exlosion_number)
		queue_free()