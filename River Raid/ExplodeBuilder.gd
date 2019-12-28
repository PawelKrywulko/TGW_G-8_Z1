extends Node2D

export var exlode_scene: PackedScene

func _ready():
	var a = 0
	while a < 5:
		yield(get_tree().create_timer(0.1), "timeout")
		a += 1
		var exlode = exlode_scene.instance();
		randomize()
		exlode.position.x = randi() % 500
		exlode.position.y = randi() % 500
		var anim = exlode.get_node("AnimatedSprite") as AnimatedSprite
		anim.play(str(randi()%2))
		add_child(exlode)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
