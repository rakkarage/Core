## Static utility functions.
extends Object
class_name Utility

## Flatten a 2D [param position] to a 1D index using [param width]. See [method unflatten].
static func flatten(position: Vector2i, width: int) -> int:
	return position.x + position.y * width

## Unflatten a 1D [param index] to a 2D position using [param width]. See [method flatten].
static func unflatten(index: int, width: int) -> Vector2i:
	return Vector2i(index % width, int(index / float(width)))

## Generate an array of integers with values starting from [param value] and incrementing by 1 for each element up to [param count].
static func array_sequence(value: int, count: int) -> Array[int]:
	return Array(range(value, value + count))

## Generate an array of integers with the specified [param value] repeated for the specified [param count].
static func array_repeat(value: int, count: int) -> Array[int]:
	var array: Array[int] = []
	array.resize(count)
	array.fill(value)
	return array

## Recursively list files in the specified [param path] and its subdirectories that match the specified [param extensions].
## If [param extensions] is empty, all files are returned.
static func list_files(path: String, extensions: Array[String] = []) -> Array[String]:
	var list: Array[String] = []
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
static func save_list(list: Array[String], path: String) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(list))
	file.close()
