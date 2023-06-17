# This script defines a `Random` class that provides several utility methods for generating random values.
# The class extends the [Node] class, which allows it to be "autoloaded" or added as a child node in the Godot scene tree.
# The class uses a [RandomNumberGenerator] object to generate random values.
extends Node

var _rng := RandomNumberGenerator.new()

## Called when the node enters the scene tree for the first time.
func _init() -> void:
	_rng.randomize() ## Randomize the random number generator

## Generates a random integer between 0 and [param maxValue] (exclusive).
## If `maxValue` is 0, the method returns 0.
func next(maxValue: int) -> int:
	return 0 if maxValue == 0 else _rng.randi() % maxValue

## Generates a random integer between [param from] and [param to] (inclusive).
func nextRange(from: int, to: int) -> int:
	return _rng.randi_range(from, to)

## Generates a random even integer between [param from] and [param to] (inclusive).
## Divides [param from] and [param to] by 2 and generates a random integer between the resulting values.
## The resulting value is then multiplied by 2 to get an even integer. See [method nextRangeOdd].
func nextRangeEven(from: int, to: int) -> int:
	return nextRange(int(from / 2.0), int(to / 2.0)) * 2

## Generates a random odd integer between [param from] and [param to] (inclusive).
## Generates a random even integer between [param from] and [param to] using the [method nextRangeEven] method,
## and then adds 1 to get an odd integer.
func nextRangeOdd(from: int, to: int) -> int:
	return nextRangeEven(from, to) + 1

## Generates a random float between [param from] and [param to] (inclusive).
## If [param from] is greater than [param to], the method returns 0.
func nextRangeFloat(from: float, to: float) -> float:
	return _rng.randf_range(from, to)

# Generates a random boolean value (true or false).
# Generates a random integer between 0 and 1 and returns true if the value is 1, false otherwise.
func nextBool() -> bool:
	return bool(next(2))

# Generates a random float value between 0 and 1 (exclusive).
func nextFloat() -> float:
	return _rng.randf()

# Generates a random `Color` object with random RGB values between 0 and 1 (exclusive).
func nextColor() -> Color:
	return Color(nextFloat(), nextFloat(), nextFloat())

## Returns a random index based on an [param array] of probabilities.
## The method calculates the total of all probabilities and selects a random value between 0 and the total.
## The method then iterates over the probabilities and adds them up until the sum is greater than the selected value.
## The index of the last probability added is returned.
## [codeblock]
##     [1, 100] # uaually return 1 in this case
## [/codeblock]
func probabilityIndex(array: Array[float]) -> int:
	var total: float = array.reduce(func(a, b): return a + b)
	var selected := nextFloat() * total
	var current := 0.0
	for i in array.size():
		current += array[i]
		if current > selected:
			return i
	return -1 # array is empty

## Returns a random key or value based on a [param dictionary] of probabilities.
## The method calculates the total of all probabilities and selects a random value between 0 and the total.
## The method then iterates over the probabilities and adds them up until the sum is greater than the selected value.
## The key or value of the last probability added is returned.
## [codeblock]
##     # usually returns "common" value in this case
##     { "common": { "name": "Common", "probability": 100 },
##       "rare": { "name": "Rare", "probability": 1 } }
##     # usually returns "common" key in this case
##     { Callable(self, "common"): 100,
##       Callable(self, "rare"): 1 }
## [/codeblock]
func probability(d: Dictionary):
	var total := 0.0
	for value in d.values():
		total += value.probability if value is Dictionary and "probability" in value else value
	var selected := nextFloat() * total
	var current := 0.0
	for key in d:
		var value = d[key]
		current += value.probability if value is Dictionary and "probability" in value else value
		if current > selected:
			return value if value is Dictionary and "probability" in value else key
	return null # dictionary is empty
