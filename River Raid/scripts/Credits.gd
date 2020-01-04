extends CanvasLayer

func _ready():
	$OKButton.connect("pressed", self, "_on_OK_pressed")

func _on_OK_pressed():
	get_tree().paused = false
	queue_free()