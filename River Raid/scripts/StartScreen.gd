extends CanvasLayer

func _ready():
	$ButtonsPanel/ButtonStartGame.connect("pressed", self, "start_game")
	$ButtonsPanel/ButtonQuit.connect("pressed", self, "quit_game")

func start_game():
	get_tree().change_scene("res://scenes/GameManager.tscn")

func quit_game():
	get_tree().quit()