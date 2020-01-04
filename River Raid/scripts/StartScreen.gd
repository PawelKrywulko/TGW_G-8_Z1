extends CanvasLayer

onready var settings: PackedScene = load("res://scenes/Settings.tscn")
onready var StartButton:= $ButtonsPanel/ButtonStartGame
onready var SettingsButton:= $ButtonsPanel/ButtonSettings
onready var HightscoreButton:= $ButtonsPanel/ButtonHighscore
onready var CreditsButton:= $ButtonsPanel/ButtonCredits
onready var QuitButton:= $ButtonsPanel/ButtonQuit

func _ready():
	#connect signals
	StartButton.connect("pressed", self, "start_game")
	QuitButton.connect("pressed", self, "quit_game")
	SettingsButton.connect("pressed", self, "settings")
	#turn music and sound or not
	var music_volume = SaveSystem.load_value("Music", "Volume")
	var is_music = SaveSystem.load_value("Music", "IsEnabled")
	var sfx_volume = SaveSystem.load_value("SFX", "Volume")
	var is_sfx = SaveSystem.load_value("SFX", "IsEnabled")
	AudioServer.set_bus_mute( 1, !is_music)
	AudioServer.set_bus_volume_db( 1, music_volume)
	AudioServer.set_bus_mute( 2, !is_sfx)
	AudioServer.set_bus_volume_db( 2, sfx_volume)
	Global.fade_in()

func start_game():
	#... the awsome sound here... :(
	$StartGameSound.play()
	Global.fade_out()
	yield(Global, "fade_out_completed")
	get_tree().change_scene("res://scenes/GameManager.tscn")

func settings():
	get_tree().paused = true
	add_child(settings.instance())
	

func quit_game():
	Global.click()
	yield(get_tree().create_timer(0.1),"timeout")
	get_tree().quit()
	
func disable_buttons():
	StartButton.disabled = true
	SettingsButton.disabled = true
	HightscoreButton.disabled = true
	CreditsButton.disabled = true
	QuitButton.pause = true