extends CanvasLayer

export var onscreen_time: int = 2

func _ready():
	Global.fade_in()
	yield(get_tree().create_timer(onscreen_time), "timeout")
	Global.fade_out()
	yield(Global, "fade_out_completed")
	get_tree().change_scene("res://scenes/StartScreen.tscn")

