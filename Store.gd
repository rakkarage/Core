## Stores data in a config file. Can specify [member _path] and [member _default] value.
extends Node
class_name Store

var _path := "user://Store.cfg"
var _file := ConfigFile.new()
var _default := { }
var data: Dictionary

func _init() -> void:
	clear()
	read()

func _exit_tree() -> void:
	write()

func read() -> void:
	var code := _file.load(_path)
	if code != OK:
		print_debug("Store.read error: ", code, ", ", _path)
		return
	for section in _file.get_sections():
		for key in _file.get_section_keys(section):
			data[section][str(key)] = _file.get_value(section, str(key))

func write() -> void:
	for section in data.keys():
		for key in data[section].keys():
			_file.set_value(section, str(key), data[section][str(key)])
	var code := _file.save(_path)
	if code != OK:
		print_debug("Store.write error: ", code, ", ", _path)

func clear() -> void:
	data = _default.duplicate()
