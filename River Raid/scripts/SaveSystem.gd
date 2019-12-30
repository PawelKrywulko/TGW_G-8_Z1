extends Node2D

var save_path: String = "res://config.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)

func _ready() -> void:
	load_all_settings()

func save_value(section: String, key: String, value) -> void:
	config.set_value(section, key, value)
	config.save(save_path)

func load_value(section: String, key: String):
	return config.get_value(section, key)

func load_all_settings() -> void:
	AudioServer.set_bus_mute(1, !SaveSystem.load_value("Music", "IsEnabled"))
	AudioServer.set_bus_mute(2, !SaveSystem.load_value("SFX", "IsEnabled"))
	AudioServer.set_bus_volume_db(1, SaveSystem.load_value("Music", "Volume"))
	AudioServer.set_bus_volume_db(2, SaveSystem.load_value("SFX", "Volume"))