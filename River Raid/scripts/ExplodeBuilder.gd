extends Node2D

class_name ExplodeBuilder

export var exlode_scene: PackedScene
export var explosion_number:= 8

func explode(begin, end):
	var a = 0
	while a < explosion_number:
		yield(get_tree().create_timer(0.05), "timeout")
		a += 1
		var boom = exlode_scene.instance();
		randomize()
		var randX = rand_range(-end.x , end.x)
		var randY = rand_range(-end.y , end.y)
		boom.position.x = begin.x + randX
		boom.position.y = begin.y + randY
		var anim = boom.get_node("AnimatedSprite") as AnimatedSprite
		anim.play(str(randi()%2))
		get_parent().add_child(boom)
	#queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
