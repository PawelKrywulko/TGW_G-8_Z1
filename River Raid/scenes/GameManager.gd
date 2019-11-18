extends Node2D

# Declare member variables here. Examples:
signal ready_to_play
signal gameloop_done
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(gameloop(), "completed")
	print("i po starcie")
	pass # Replace with function body.
func gameloop():
	print("startuje gameloop")
	emit_signal("gameloop_done")
	yield(get_tree().create_timer(2),"timeout")
func start_game():
	pass
func game_over():
	pass
func reset_game():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
