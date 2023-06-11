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

# returns probability index: [1, 100]
func probabilityIndex(a: Array) -> int:
	var total = a.reduce(func(a, b): return a + b)
	var selected := next(total)
	var current := 0
	for i in a.size():
		current += a[i]
		if current > selected:
			return i
	return -1 # should never happen

# returns dictionary value if dictionary and has probability key:
# { "common": { "name": "Common", "probability": 100 },
#   "rare": { "name": "Rare", "probability": 1 } }
# else assumes value is probability and returns dictionary key:
# { Callable(self, "common"): 100,
#   Callable(self, "rare"): 1 }
func probability(d: Dictionary):
	var total := 0
	for value in d.values():
		total += value.probability if value is Dictionary and "probability" in value else value
	var selected := next(total)
	var current := 0
	for key in d:
		var value = d[key]
		current += value.probability if value is Dictionary and "probability" in value else value
		if current > selected:
			return value if value is Dictionary and "probability" in value else key
	return null # should never happen
