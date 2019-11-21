extends CanvasLayer

onready var lives_panel : Label = $Lives
onready var fuel_panel : Label = $Fuel
onready var score_panel : Label= $Score
var score = 0

func _on_fuel_change(value):
	fuel_panel.text = "Fuel: " + str(value)

func _on_lives_changed(value):
	lives_panel.text = "Lives: " + str(value)

func _on_score_change(value):
	score += value
	score_panel.text = "Score: " + str(value)
