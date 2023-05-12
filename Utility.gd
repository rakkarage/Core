extends Object
class_name Utility

static func stfu(_ignore) -> void: pass

static func indexV(p: Vector2, width: int) -> int:
	return index(int(p.x), int(p.y), width)

static func index(x: int, y: int, width: int) -> int:
	return int(y * width + x)

static func position(i: int, width: int) -> Vector2:
	var y := int(i / float(width))
	var x := int(i - width * y)
	return Vector2(x, y)

static func arraySequence(value: int, count: int) -> Array:
	var array := []
	for i in range(count):
		array.append(value + i)
	return array

static func arrayRepeat(value, count: int) -> Array:
	var array := []
	for _i in range(count):
		array.append(value)
	return array

func listFiles(path: String, ends: Array = []) -> Array:
	var list := []
	for dir in DirAccess.get_directories_at(path):
		if !dir.begins_with("."):
			list += listFiles(path + "/" + dir)
	for file in DirAccess.get_files_at(path):
		if !file.begins_with(".") and !file.ends_with(".import"):
			if not ends.is_empty():
				var ok = false
				for end in ends:
					if file.ends_with(end):
						ok = true
				if ok:
					list.append(path + "/" + file)
			else:
				list.append(path + "/" + file)
	return list

func saveFiles(list: Array, path: String) -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(list))
	file.close()
