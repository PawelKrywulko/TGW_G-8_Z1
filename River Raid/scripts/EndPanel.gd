extends CanvasLayer

onready var restart_button:= $RestartButton
onready var main_menu_button:= $MainMenuButton
var game_score: int = 0

func _ready():
	restart_button.connect("pressed", self, "restart")
	main_menu_button.connect("pressed", self, "main_menu")
	var hud = get_parent().get_node("HUD")
	if hud != null:
		game_score = hud.score
	var hiscore = SaveSystem.load_value("Highscore","Score")
	if game_score > hiscore:
		$Text.text = "Congratulations!\nYou beat the highscore!\nYour score is:"
		SaveSystem.save_value("Highscre","Score",game_score)
	else:
		$Text.text = "You didn't beat highscore!\nTry harder!\nYour score is:"
	$Score.text = str(game_score)

func restart():
	Global.click()
	Global.fade_out()
	set_pause_mode(Node.PAUSE_MODE_STOP)
	yield(Global,"fade_out_completed")
	get_tree().change_scene("res://scenes/GameManager.tscn")

func main_menu():
	Global.click()
	#Global.fade_unpause()
	Global.fade_out()
	set_pause_mode(Node.PAUSE_MODE_STOP)
	yield(Global,"fade_out_completed")
	get_tree().change_scene("res://scenes/StartScreen.tscn")
	queue_free()
