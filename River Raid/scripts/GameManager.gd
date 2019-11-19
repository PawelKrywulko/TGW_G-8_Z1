extends Node2D

signal ready_to_go

export var prestart_speed: float
export var max_prestart_position_y: int
export var min_reset_position_y: int
var player: Node2D
var starting_point : Vector2

func _ready():
	player = $Player
	starting_point = $StartingPoint.position
	connect("ready_to_go", player, "_on_ready_to_go")
	yield(gameloop(), "completed")

func gameloop():
	yield(start_game(),"completed")
	yield(game_running(),"completed")
	yield(gameover(),"completed")

func start_game():
	player.hide()
	while true:
		auto_move()
		yield(get_tree(),"idle_frame")
		if player.position.y <= max_prestart_position_y:
			#black screen animation fade and continue after finished
			reset_game()
			break

func reset_game():
	player.position.x = starting_point.x
	player.position.y = min_reset_position_y

	while true:
		auto_move()
		yield(get_tree(),"idle_frame")
		if player.position.y <= starting_point.y:
			player.show()
			emit_signal("ready_to_go")
			break

func game_running():
	yield(player, "no_more_lives")

func gameover():
	yield(get_tree(),"idle_frame")
	gameloop()

func auto_move():
	player.position += Vector2(0,-1) * prestart_speed * get_process_delta_time()

