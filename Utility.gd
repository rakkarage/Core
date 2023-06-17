## A collection of static utility functions, constants, and enums.
extends Object
class_name Utility

## Flatten a 2D [param position] to a 1D index using [param width]. See [method unflatten].
## This method takes a 2D position and the width of a grid and returns the corresponding 1D index of the position in the flattened grid.
## The method calculates the index by adding the x coordinate of the position to the product of the y coordinate and the width of the grid.
static func flatten(position: Vector2i, width: int) -> int:
	return position.x + position.y * width

## Unflatten a 1D [param index] to a 2D position using [param width]. See [method flatten].
## This method takes a 1D index and the width of a grid and returns the corresponding 2D position in the unflattened grid.
## The method calculates the position by taking the modulo of the index with the width of the grid as the x coordinate and the integer division of the index by the width of the grid as the y coordinate.
static func unflatten(index: int, width: int) -> Vector2i:
	return Vector2i(index % width, int(index / float(width)))

## Generate an array of integers with values starting from [param value] and incrementing by 1 for each element up to [param count].
static func arraySequence(value: int, count: int) -> Array[int]:
	return Array(range(value, value + count))

## Generate an array of integers with the specified [param value] repeated for the specified [param count].
static func arrayRepeat(value: int, count: int) -> Array[int]:
	var array := []
	array.resize(count)
	array.fill(value)
	return array

## Recursively list files in the specified [param path] and its subdirectories that match the specified [param extensions].
## If [param extensions] is empty, all files are returned.
static func listFiles(path: String, extensions: Array = []) -> Array[String]:
	var list := []
	for dir in DirAccess.get_directories_at(path):
		if not dir.begins_with("."):
			list.append_array(Utility.listFiles(path + dir + "/", extensions))
	for file in DirAccess.get_files_at(path):
		var extension := file.split(".")[-1]
		if not file.begins_with(".") and extension != "import":
			if extensions.is_empty() or extension in extensions:
				list.append(path + file)
	return list

## Save the specified [param list] as a JSON string to the specified [param path].
static func saveList(list: Array[String], path: String) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(list))
	file.close()
