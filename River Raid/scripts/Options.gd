extends CanvasLayer

onready var continue_button:= $ContinueButton
onready var restart_button:= $RestartButton
onready var settings_button:= $SettingsButton
onready var main_menu_button:= $MainMenuButton

func _ready():
	continue_button.connect("pressed", self, "play")
	restart_button.connect("pressed", self, "restart")
	settings_button.connect("pressed", self, "settings")
	main_menu_button.connect("pressed", self, "main_menu")

func play():
	var anim := get_tree().get_root().get_node("GameManager/Player/AnimatedSprite")
	anim.frame = 0
	anim.stop()
	get_tree().paused = false
	queue_free()
	
func restart():
	Global.click()
	Global.fade_out()
	set_pause_mode(Node.PAUSE_MODE_STOP)
	yield(Global,"fade_out_completed")
	get_tree().change_scene("res://scenes/GameManager.tscn")


func settings():
	Global.click()
	var settings_scene = load("res://scenes/Settings.tscn")
	add_child(settings_scene.instance())
	set_pause_mode(Node.PAUSE_MODE_STOP)
	
func main_menu():
	Global.click()
	#Global.fade_unpause()
	Global.fade_out()
	set_pause_mode(Node.PAUSE_MODE_STOP)
	yield(Global,"fade_out_completed")
	get_tree().change_scene("res://scenes/StartScreen.tscn")
	queue_free()
