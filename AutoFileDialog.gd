## A file dialog that can be used to load or save files.
extends FileDialog

var _old_ok: Callable ## The last ok callback.

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("file_selected", func(_ignore): hide())

## Show a load dialog with default values.
func show_load(ok: Callable, filter: Array[String]) -> void:
	return show_dialog(FileDialog.FILE_MODE_OPEN_FILE, ok, filter)

## Show a save dialog with default values.
func show_save(ok: Callable, filter: Array[String]) -> void:
	return show_dialog(FileDialog.FILE_MODE_SAVE_FILE, ok, filter)

## Show a dialog with custom values.
func show_dialog(use_mode: FileDialog.FileMode, ok: Callable, filter: Array[String] = ["*.* ; All Files"], file := "file" + str(Random.next(1000000)), path := OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)) -> void:
	access = FileDialog.ACCESS_FILESYSTEM
	file_mode = use_mode
	current_dir = path
	current_file = file
	filters = filter
	size = Vector2(800, 600)
	popup_centered()
	if _old_ok.is_valid():
		disconnect("file_selected", _old_ok)
	connect("file_selected", ok)
	_old_ok = ok
