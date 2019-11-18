extends Node2D

# Declare member variables here. Examples:
export var prestart_speed: float
export var max_prestart_position_y: int
var player: Node2D
var starting_point : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $Player
	starting_point = $StartingPoint.position
	yield(gameloop(), "completed")
	
func gameloop():
	print("gameloop")
	yield(prestart(),"completed")
	#animation fade and continue after finished
func prestart():
	var nextframe: bool = false
	player.hide()
	print("prestart")
	while true:
		player.position += Vector2(0,-1) * prestart_speed * get_process_delta_time()
		yield(get_tree(),"idle_frame")
		if player.position.y <= max_prestart_position_y && nextframe == false:
			player.position.y = 1600
			nextframe = true
		if player.position.y <= starting_point.y && nextframe:
			player.show()
			yield(get_tree().create_timer(1.5),"timeout")
			player.speed = 300
			break

func startgame():
	print("start game")
	yield()
	pass
func gameover():
	pass
func resetgame():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
