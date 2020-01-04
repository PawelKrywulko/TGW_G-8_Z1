extends CanvasLayer

func _ready():
	$OKButton.connect("pressed", self, "_on_OK_pressed")
	
	$MusicSlider.value = SaveSystem.load_value("Music", "Volume")
	$MusicCheckBox.pressed = SaveSystem.load_value("Music", "IsEnabled")
	$SFXSlider.value = SaveSystem.load_value("SFX", "Volume")
	$SFXCheckBox.pressed = SaveSystem.load_value("SFX", "IsEnabled")

func _process(delta):
	AudioServer.set_bus_mute( 1, !$MusicCheckBox.pressed)
	AudioServer.set_bus_volume_db( 1, $MusicSlider.value)
	AudioServer.set_bus_mute( 2, !$SFXCheckBox.pressed)
	AudioServer.set_bus_volume_db( 2, $SFXSlider.value)
	
func _on_OK_pressed():
	SaveSystem.save_value("Music", "IsEnabled", $MusicCheckBox.pressed)
	SaveSystem.save_value("Music", "Volume", $MusicSlider.value)
	SaveSystem.save_value("SFX", "Volume", $SFXSlider.value)
	SaveSystem.save_value("SFX", "IsEnabled", $SFXCheckBox.pressed)	
	get_tree().paused = false
	queue_free()
