extends CanvasLayer

func _ready():
	$ButtonsPanel/ButtonStartGame.connect("pressed", self, "start_game")
	$ButtonsPanel/ButtonQuit.connect("pressed", self, "quit_game")

func start_game():
	Global.click()
	get_tree().change_scene("res://scenes/GameManager.tscn")

func quit_game():
	Global.click()
	yield(get_tree().create_timer(0.1),"timeout")
	get_tree().quit()