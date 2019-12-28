extends Node2D

var scaler: Vector2

func _ready():
	scaler = Vector2(0.75,0.75)
func _process(delta):
	scale += scaler * delta
	if scale.x > 1.2:
		scaler = Vector2(1.25,1.25)
		scaler *= -1
	if scale.x <= 0:
		queue_free()

