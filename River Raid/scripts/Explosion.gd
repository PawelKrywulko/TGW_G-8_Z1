extends Area2D

onready var anim := $AnimatedSprite

func _ready():
	anim.play("boom")
	yield(anim,"animation_finished")
	yield(get_tree().create_timer(0.2),"timeout")
	queue_free()

