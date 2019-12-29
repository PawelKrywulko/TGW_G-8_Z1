extends CanvasLayer

func _ready():
	$MusicSlider.value = SaveSystem.load_value("Music", "Volume")
	$SoundCheckBox.pressed = SaveSystem.load_value("Music", "MusicEnabled")
	$SFXSlider.value = SaveSystem.load_value("SFX", "Volume")
	AudioServer.set_bus_mute( 0, !$SoundCheckBox.pressed)
	AudioServer.set_bus_volume_db( 1, $MusicSlider.value)
	AudioServer.set_bus_volume_db( 2, $SFXSlider.value)

func _process(delta):
	AudioServer.set_bus_mute( 0, !$SoundCheckBox.pressed)
	AudioServer.set_bus_volume_db( 1, $MusicSlider.value)
	AudioServer.set_bus_volume_db( 2, $SFXSlider.value)
	
func _on_SaveButton_pressed():
	SaveSystem.save_value("Music", "MusicEnabled", $SoundCheckBox.pressed)
	SaveSystem.save_value("Music", "Volume", $MusicSlider.value)
	SaveSystem.save_value("SFX", "Volume", $SFXSlider.value)
	get_tree().paused = false
	queue_free()
