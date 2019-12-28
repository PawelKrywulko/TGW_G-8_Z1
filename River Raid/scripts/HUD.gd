extends CanvasLayer

signal bonus_score_reached

onready var lives_panel : Label = $Lives
onready var fuel_bar : Label = $Fuel
onready var score_panel : Label= $Score
onready var fade_anim : AnimationPlayer = $Fader/AnimationPlayer

var bonus_score: int = 10000
var score: int = 0

func _ready():
	var game_manager = get_parent()
	game_manager.connect("fade", self, "_fade")

func _on_score_changed(value):
	score += value
	if score > bonus_score:
		print("bonus_score_reached")
		emit_signal("bonus_score_reached")
		bonus_score += 10000
	score_panel.text = "SCORE: " + str(score)

func _on_Player_lives_left(value):
	lives_panel.text = str(value)

func _on_Player_fuel_left(value: float):
	fuel_bar.value = value

func _on_Player_out_of_lives():
	#po testach trzeba usunac poniższa linijke
	#score = 0
	score_panel.text = "SCORE: " + str(score)
	
func _fade():
	fade_anim.play("FadeOut")
	yield(fade_anim,"animation_finished")
	fade_anim.play("BlackScreen")
	yield(fade_anim,"animation_finished")
	fade_anim.play("FadeIn")
	yield(fade_anim,"animation_finished")