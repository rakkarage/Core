extends Node

var _rng := RandomNumberGenerator.new()

func _init() -> void:
	_rng.randomize()

func next(n: int) -> int:
	return 0 if n == 0 else _rng.randi() % n

func nextRange(from: int, to: int) -> int:
	return _rng.randi_range(from, to)

func nextRangeEven(from: int, to: int) -> int:
	return nextRange(int(from / 2.0), int(to / 2.0)) * 2

func nextRangeOdd(from: int, to: int) -> int:
	return nextRangeEven(from, to) + 1

func nextBool() -> bool:
	return bool(next(2))

func nextFloat() -> float:
	return _rng.randf()

func nextColor() -> Color:
	return Color(nextFloat(), nextFloat(), nextFloat())

# https://www.codeproject.com/Articles/420046/Loot-Tables-Random-Maps-and-Monsters-Part-I
func probabilityIndex(a: Array) -> int:
	var total = a.reduce(func(a, b): return a + b)
	var selected := next(total)
	var current := 0
	for i in a.size():
		current += a[i]
		if current > selected:
			return i
	return -1 # should never happen

# returns priority value if is dictionary and has priority key:
# { "common": { "name": "Common", "priority": 100 },
#   "rare": { "name": "Rare", "priority": 1 } }
# else assumes value is priority and returns priority key:
# { Callable(self, "common"): 100,
#   Callable(self, "rare"): 1 }
func probability(d: Dictionary):
	var total := 0
	for key in d:
		var value = d[key]
		total += value.priority if value is Dictionary and "priority" in value else value
	var selected := next(total)
	var current := 0
	for key in d:
		var value = d[key]
		current += value.priority if value is Dictionary and "priority" in value else value
		if current > selected:
			return value if value is Dictionary and "priority" in value else key
	return null # should never happen
