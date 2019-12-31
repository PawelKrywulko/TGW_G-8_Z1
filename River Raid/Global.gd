extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func click():
	$Click.set_pitch_scale(rand_range(1,1.2))
	$Click.play()
