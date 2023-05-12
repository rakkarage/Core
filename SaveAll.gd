@tool
extends EditorScript

func _run() -> void:
	for file in Utility.listFiles("res://", [".tscn", ".tres"]):
		ResourceSaver.save(load(file))
