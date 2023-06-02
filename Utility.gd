extends Object
class_name Utility

static func stfu(_ignore) -> void: pass

static func tileIndex(p: Vector2i, w: int) -> int:
	return p.x + p.y * w

static func tilePosition(i: int, w: int) -> Vector2i:
	return Vector2i(i % w, int(i / float(w)))

static func constrainRect(world: Rect2, map: Rect2) -> Vector2:
	return Utility.constrain(world.position, world.end, map.position, map.end)

static func constrain(minWorld: Vector2, maxWorld: Vector2, minMap: Vector2, maxMap: Vector2) -> Vector2:
	var delta := Vector2.ZERO
	if minWorld.x > minMap.x: delta.x += minMap.x - minWorld.x
	if maxWorld.x < maxMap.x: delta.x -= maxWorld.x - maxMap.x
	if minWorld.y > minMap.y: delta.y += minMap.y - minWorld.y
	if maxWorld.y < maxMap.y: delta.y -= maxWorld.y - maxMap.y
	return delta

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

static func listFiles(path: String, extensions: Array = []) -> Array:
	var list := []
	for dir in DirAccess.get_directories_at(path):
		if not dir.begins_with("."):
			list.append_array(Utility.listFiles(path + dir + "/", extensions))
	for file in DirAccess.get_files_at(path):
		var ext := file.split(".")[-1]
		if not file.begins_with(".") and ext != "import":
			if extensions.is_empty() or ext in extensions:
				list.append(path + file)
	return list

static func saveList(list: Array, path: String) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(list))
	file.close()
