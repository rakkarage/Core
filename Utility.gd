extends Object
class_name Utility

static func arraySequence(value: int, count: int) -> Array:
	return Array(range(value, value + count))

static func arrayRepeat(value: int, count: int) -> Array:
	var array := []
	array.resize(count)
	array.fill(value)
	return array

static func listFiles(path: String, extensions: Array = []) -> Array:
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

static func saveList(list: Array, path: String) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(list))
	file.close()
