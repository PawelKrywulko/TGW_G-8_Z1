extends CanvasLayer

func _input(event) -> void:
	if event is InputEventKey and event.pressed:
		get_tree().change_scene("res://scenes/GameManager.tscn")
