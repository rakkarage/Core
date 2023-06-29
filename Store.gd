## Stores data in a config file. Can specify [member _path] and [member _default] value.
extends Node
class_name Store

var _path := "user://Store.cfg"
var _file := ConfigFile.new()
var _default := {}
var data: Dictionary

func _init() -> void:
	clear()
	read()

func _exit_tree() -> void:
	write()

func read() -> void:
	if _file.load(_path) == OK:
		for section in data.keys():
			for key in data[section]:
				data[section][key] = _file.get_value(section, key)

func write() -> void:
	for section in data.keys():
		for key in data[section]:
			_file.set_value(section, key, data[section][key])
	_file.save(_path)

func clear() -> void:
	data = _default.duplicate()
