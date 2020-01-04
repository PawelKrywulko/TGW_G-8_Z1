extends Control

export var on_enter_size: Vector2

func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited",self,"_on_mouse_exited")
	
func _on_mouse_entered():
	if can_process():
		Global.click()
		rect_scale = on_enter_size

func _on_mouse_exited():
	if can_process():
		rect_scale = Vector2(1,1)
