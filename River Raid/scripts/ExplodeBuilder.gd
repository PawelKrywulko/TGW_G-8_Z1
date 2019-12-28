extends Node2D

class_name ExplodeBuilder

export var exlode_scene: PackedScene
var explosion_number: int = 0

func explode(begin, end, number):
	
	explosion_number += number
	
	var a = 0
	while explosion_number > 0:
		explosion_number -= 1
		#yield(get_tree(),"idle_frame")
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
