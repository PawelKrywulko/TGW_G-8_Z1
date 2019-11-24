extends CanvasLayer

onready var lives_panel : Label = $Lives
onready var fuel_panel : Label = $Fuel
onready var score_panel : Label= $Score
onready var fade_anim : AnimationPlayer = $Fader/AnimationPlayer
var score = 0

func _ready():
	var game_manager = get_parent()
	game_manager.connect("fade", self, "_fade")

func _on_score_changed(value):
	score += value
	score_panel.text = "Score: " + str(score)

func _on_Player_lives_left(value):
	lives_panel.text = "Lives: " + str(value)

func _on_Player_fuel_left(value):
	fuel_panel.text = "Fuel: " + str(value)

func _on_Player_out_of_lives():
	score = 0
	score_panel.text = "Score: " + str(score)
	
func _fade():
	fade_anim.play("FadeOut")
	yield(fade_anim,"animation_finished")
	fade_anim.play("BlackScreen")
	yield(fade_anim,"animation_finished")
	fade_anim.play("FadeIn")
	yield(fade_anim,"animation_finished")