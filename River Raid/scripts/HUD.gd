extends CanvasLayer

onready var lives_panel : Label = $Lives
onready var fuel_panel : Label = $Fuel
onready var score_panel : Label= $Score

func _ready():
	connect("lives_left", self, "_on_lives_changed")
	connect("fuel_left", self, "_on_fuel_changed")
	connect("fuel_tank_destroyed", self, "_on_score_changed")

func _on_fuel_change(value):
	fuel_panel.text = "Fuel: " + value

func _on_lives_changed(value):
	lives_panel.text = "Lives: " + value
	
func _on_score_change(value):
	score_panel.text = "Score: " + value
