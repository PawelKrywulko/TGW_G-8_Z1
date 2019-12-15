extends Area2D

onready var anim := $AnimatedSprite

func _ready():
	anim.play("boom")
	yield(anim, "animation_finished")
	queue_free()
