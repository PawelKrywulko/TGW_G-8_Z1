extends Node2D

signal ready_to_go
signal reset
signal kill_enemies_behind
signal fade

export (Array, int) var checkpoints
export var bridge_destroyed: int = 0
export var prestart_speed: float
export var max_prestart_position_y: int
export var min_reset_position_y: int
export var fade_anim_offset : int
var fade_anim_played : bool = false
onready var player := $Player
var starting_point : Vector2
var reset_point: Vector2
var first_run: bool = true
var options_panel: PackedScene = load("res://scenes/Options.tscn")
var ready_to_go: bool = false
#maps
onready var buildmap_point := $BuildMapPoint
var first_build: bool = true
var current_map
var previous_map_first
var previous_map_second

func _ready() -> void:
	#build_map()
	get_tree().paused = false
	starting_point = $StartingPoint.position
	Global.fade_in()
	gameloop()

func _process(delta):
	check_map()

func _input(event):
	if event is InputEventKey:
		if event.pressed && event.scancode == KEY_ESCAPE && ready_to_go:
			add_child(options_panel.instance())
			get_tree().paused = true

func gameloop() -> void:
	yield(start_game(),"completed")
	yield(game_running(),"completed")
	gameover()

func start_game() -> void:
	fade_anim_played = false
	player.hide()
	while true:
		if can_process():
			auto_move()
		yield(get_tree(),"idle_frame")
		#black screen animation fade in and out
		if player.position.y <= max_prestart_position_y + fade_anim_offset && !fade_anim_played:
			fade_anim_played = true
			Global.fade_out()
		if player.position.y <= max_prestart_position_y:
			Global.fade_in()
			reset_game()
			break

func reset_game():
	ready_to_go = false
	!first_run && yield(get_tree().create_timer(2), "timeout")
	first_run = false
	emit_signal("reset")
	emit_signal("kill_enemies_behind")
	reset_point.y = starting_point.y - 5760 * bridge_destroyed
	player.position.x = starting_point.x
	player.position.y = reset_point.y
	$Player/Camera2D.align()
	player.show()
	ready_to_go = true
	emit_signal("ready_to_go")

func game_running():
	yield(player, "out_of_lives")
	ready_to_go = false
	yield(get_tree().create_timer(2), "timeout")
	#prepere to connect to end panel
	#yield(endpanel,"gameover")
	#get_tree().change_scene("res://scenes/StartScreen.tscn")
	print("game+stoprunning")
func gameover():
	var game_over_panel: PackedScene = load("res://scenes/EndPanel.tscn")
	add_child(game_over_panel.instance())

func auto_move():
	player.position += Vector2(0,-1) * prestart_speed * get_process_delta_time()

func _on_bridge_destroyed():
	bridge_destroyed += 1
	var levels = $Levels.get_children()
	for level in levels:
		level.get_node("AnimationPlayer").play("BridgeDestroyed")

func check_map():
	if $Player.position.y <= buildmap_point.position.y:
		build_map()
		buildmap_point.position.y -= 5760
func build_map():
	randomize()
	var random_map = load("res://scenes/maps/Level" + str(randi()%4 + 2) + ".tscn")
	var map_to_add = random_map.instance()
	if first_build:
		first_build = false
		$Levels/Level0.queue_free()
		$Levels/Level1.queue_free()
		$Levels/Level2.queue_free()
		$Levels/Level3.queue_free()
		previous_map_second = $Levels/Level4
		previous_map_first = $Levels/Level5
		current_map = map_to_add
	else:
		previous_map_second.queue_free()
		previous_map_second = previous_map_first
		previous_map_first = current_map
		current_map = map_to_add

	current_map.position.y = previous_map_first.position.y - 5760
	$Levels.add_child(current_map)