## This script is an editor tool that saves all scenes and resources in the project.
## Right click on script in the Godot script editor and select "Run" to run the script.
@tool
extends EditorScript

## Uses a for loop to iterate over all `.tscn` and `.tres` files in the project directory. See [method Utility.listFiles] for more information.
## For each file, the method loads the resource using the `load` method and saves it using the `ResourceSaver.save` method.
func _run() -> void:
	for file in Utility.listFiles("res://", ["tscn", "tres"]):
		ResourceSaver.save(load(file))
