extends CanvasLayer

func _ready():
	$SoundCheckBox.pressed = SaveSystem.load_value("Music", "MusicEnabled")
	$VolumeSlider.value = SaveSystem.load_value("Music", "Volume")
	AudioServer.set_bus_volume_db( 0, $VolumeSlider.value)
	AudioServer.set_bus_mute( 0, !$SoundCheckBox.pressed)

func _process(delta):
	AudioServer.set_bus_volume_db( 0, $VolumeSlider.value)
	AudioServer.set_bus_mute( 0, !$SoundCheckBox.pressed)

func _on_CloseButton_pressed():
	queue_free()

func _on_SaveButton_pressed():
	SaveSystem.save_value("Music", "MusicEnabled", $SoundCheckBox.pressed)
	SaveSystem.save_value("Music", "Volume", $VolumeSlider.value)
	AudioServer.set_bus_volume_db( 0, $VolumeSlider.value)
	AudioServer.set_bus_mute( 0, !$SoundCheckBox.pressed)
	get_tree().paused = false
	queue_free()
