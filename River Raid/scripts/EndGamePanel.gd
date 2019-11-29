extends CanvasLayer

signal panel_closed

onready var timer: Timer
onready var score_info: Label
onready var info_message : Label

export var waiting_time : int

func _ready() -> void:
	score_info = $ScoreInfo
	var score = get_parent().get_node("HUD").score
	score_info.text = "Your final score is : " + str(score)
	
	info_message = $Info
	info_message.text = "Press any key or wait " + str(waiting_time) + " sec..."
	
	timer = $WaitTimer
	timer.start()
	
	wait()

func wait() -> void:
	while true:
		yield($WaitTimer, "timeout")
		waiting_time -= 1
		info_message.text = "Press any key or wait " + str(waiting_time) + " sec..."
		if waiting_time <= 0 :
			get_tree().change_scene("res://scenes/StartScreen.tscn")
