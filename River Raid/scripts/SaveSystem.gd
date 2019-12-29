extends Node2D

var save_path: String = "res://config.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)

func save_value(section: String, key: String, value) -> void:
	config.set_value(section, key, value)
	config.save(save_path)

func load_value(section: String, key: String):
	return config.get_value(section, key)