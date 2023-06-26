## This script is an editor tool that saves all scenes and resources in the project.
## Right click on script in the Godot script editor and select "Run" to run the script.
@tool
extends EditorScript

## Iterate over all `.tscn` and `.tres` files in the project directory. See [method Utility.listFiles].
## For each file, loads [method @GDScript.load] and saves using [method ResourceSaver.save].
func _run() -> void:
	for file in Utility.list_files("res://", ["tscn", "tres"]):
		ResourceSaver.save(load(file))
