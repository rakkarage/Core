## Resaves all scenes and resources in the project.
## Right click on script in the Godot script editor and select "Run" to execute the script.
@tool
extends EditorScript

func _run() -> void:
	for file in Utility.list_files("res://", ["tscn", "tres"]):
		ResourceSaver.save(load(file))
