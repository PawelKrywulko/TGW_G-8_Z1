extends Node2D

signal ready_to_go
signal reset
signal fade

export (Array, int) var checkpoints
export var prestart_speed: float
export var max_prestart_position_y: int
export var min_reset_position_y: int
export var fade_anim_offset : int
var fade_anim_played : bool = false
onready var player := $Player
var starting_point : Vector2

func _ready() -> void:
	starting_point = $StartingPoint.position
	gameloop()

func gameloop() -> void:
	yield(start_game(),"completed")
	yield(game_running(),"completed")
	gameover()

func start_game() -> void:
	fade_anim_played = false
	player.hide()
	while true:
		auto_move()
		yield(get_tree(),"idle_frame")
		#black screen animation fade in and out
		if player.position.y <= max_prestart_position_y + fade_anim_offset && !fade_anim_played:
			fade_anim_played = true
			emit_signal("fade")
		if player.position.y <= max_prestart_position_y:
			reset_game()
			break

func reset_game():
	
	emit_signal("reset")
	player.position.x = 960
	player.position.y = checkpoints[3] + min_reset_position_y
	starting_point.y = checkpoints[3]

	while true:
		auto_move()
		yield(get_tree(),"idle_frame")
		print(player.position.y)
		if player.position.y <= starting_point.y:
			player.show()
			emit_signal("ready_to_go")
			break

func game_running():
	yield(player, "out_of_lives")
	#prepere to connect to end panel
	#yield(endpanel,"gameover")
	#get_tree().change_scene("res://scenes/StartScreen.tscn")
	print("game+stoprunning")
func gameover():
	var game_over_panel: PackedScene = load("res://scenes/EndGamePanel.tscn")
	add_child(game_over_panel.instance())
	set_process(false)

func auto_move():
	player.position += Vector2(0,-1) * prestart_speed * get_process_delta_time()

