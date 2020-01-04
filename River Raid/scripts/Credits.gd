extends CanvasLayer

func _ready():
	$Close/CloseButton.connect("pressed", self, "close")

func close():
	get_tree().paused = false
	queue_free()