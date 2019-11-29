extends CanvasLayer

signal panel_closed

onready var timer: Timer
onready var score_info: Label
onready var info_message : Label

export var waiting_time : int
var anykey_pressed: bool

func _ready() -> void:
	anykey_pressed = false
	
	score_info = $ScoreInfo
	var score = get_parent().get_node("HUD").score
	score_info.text = "Your final score is : " + str(score)
	
	info_message = $Info
	info_message.text = "Press any key or wait " + str(waiting_time) + " sec..."
	
	timer = $WaitTimer
	timer.start(waiting_time + 1)

func _input(event) -> void:
	if event is InputEventKey and event.pressed:
		anykey_pressed = true

func _process(delta):
	#delay timer to prevent unwittingly key pressed 
	yield(get_tree().create_timer(1),"timeout")
	waiting_time = timer.get_time_left()
	if waiting_time <= 0 || anykey_pressed:
		get_tree().change_scene("res://scenes/StartScreen.tscn")
	else:
		info_message.text = "Press any key or wait " + str(waiting_time) + " sec..."

