extends CanvasLayer

signal panel_closed

onready var timer: Timer
onready var info_message : Label

export var waiting_time : int

func _ready():
	timer = $WaitTimer
	timer.start()
	info_message = $Info
	info_message.text = "Press any key or wait " + str(waiting_time) + " sec..."
	wait()

func wait():
	while true:
		yield($WaitTimer, "timeout")
		waiting_time -= 1
		info_message.text = "Press any key or wait " + str(waiting_time) + " sec..."
		if waiting_time <= 0 :
			get_tree().change_scene("res://scenes/StartScreen.tscn")
