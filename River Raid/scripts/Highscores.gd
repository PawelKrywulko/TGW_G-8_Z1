extends CanvasLayer

onready var score : Label = get_node("Text/Score")

func _ready():
	$OKButton.connect("pressed", self, "_on_OK_pressed")
	var s = SaveSystem.load_value("Highscore","Score")
	score.text = str(s)
	
func _on_OK_pressed():
	get_tree().paused = false
	queue_free()
