extends Node

signal fade_out_completed

onready var anim_fade := $Fader/AnimationPlayer

func _ready():
	pass # Replace with function body.

func click():
	$Click.set_pitch_scale(rand_range(1,1.2))
	$Click.play()

func fade_in():
	anim_fade.play("FadeIn")
	yield(anim_fade, "animation_finished")

func fade_out():
	anim_fade.play("FadeOut")
	yield(anim_fade, "animation_finished")
	emit_signal("fade_out_completed")