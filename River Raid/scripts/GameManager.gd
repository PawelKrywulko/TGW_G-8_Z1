extends Node2D

signal ready_to_go
signal reset
signal fade

export (Array, int) var checkpoints
var bridge_destroyed: int = 0
export var prestart_speed: float
export var max_prestart_position_y: int
export var min_reset_position_y: int
export var fade_anim_offset : int
var fade_anim_played : bool = false
onready var player := $Player
var starting_point : Vector2
var reset_point: Vector2

func _ready() -> void:
	starting_point = $StartingPoint.position
	gameloop()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			var settings_panel: PackedScene = load("res://scenes/Settings.tscn")
			add_child(settings_panel.instance())
			set_process(false)
			get_tree().paused = true

func gameloop() -> void:
	yield(start_game(),"completed")
	yield(game_running(),"completed")
	gameover()

func start_game() -> void:
	fade_anim_played = false
	player.hide()
	while true:
		yield(get_tree(),"idle_frame")
		if !get_tree().paused:
			auto_move()
			#black screen animation fade in and out
			if player.position.y <= max_prestart_position_y + fade_anim_offset && !fade_anim_played:
				fade_anim_played = true
				emit_signal("fade")
			if player.position.y <= max_prestart_position_y:
				reset_game()
				break

func reset_game():
	
	emit_signal("reset")
	reset_point.y = starting_point.y - 5760 * bridge_destroyed
	player.position.x = starting_point.x
	player.position.y = reset_point.y + min_reset_position_y

	while true:
		yield(get_tree(),"idle_frame")
		if !get_tree().paused:
			auto_move()
			print(player.position.y)
			if player.position.y <= reset_point.y:
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

func _on_bridge_destroyed():
	bridge_destroyed += 1
