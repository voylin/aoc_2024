extends Control

var data: Array[PackedInt64Array] = []
var total: int = 0


func _ready() -> void:
	print("Day 02 - Part one result: ", part_one())
	total = 0
	print("Day 02 - Part two result: ", part_two())


func part_one() -> int:
	var l_file: FileAccess = FileAccess.open("res://02/data.txt", FileAccess.READ)
	var l_line: PackedStringArray = l_file.get_line().split(' ')

	while !l_file.eof_reached():
		var l_temp: PackedInt64Array = []

		for l_string: String in l_line:
			l_temp.append(int(l_string))

		data.append(l_temp)
		l_line = l_file.get_line().split(' ')

	for l_index: int in data.size():
		var l_positive: bool = true
		var l_skip: bool = false

		if data[l_index][0] > data[l_index][1]:
			l_positive = false

		for i: int in data[l_index].size() - 1:
			var l_value: int =  data[l_index][i + 1] - data[l_index][i]

			if (l_positive and l_value < 0) or (!l_positive and l_value > 0):
				l_skip = true
				break
			if absi(l_value) > 3 or l_value == 0:
				l_skip = true
				break

		if !l_skip:
			total += 1
	
	return total


func part_two() -> int:
	for l_array: PackedInt64Array in data:
		if _check_normal(l_array):
			total += 1
			continue

		for i:int in l_array.size():
			var l_temp: PackedInt64Array = l_array.duplicate()
			l_temp.remove_at(i)

			if _check_normal(l_temp):
				total += 1
				break

	return total


func _check_normal(a_array: PackedInt64Array) -> bool:
	var l_positive: bool = a_array[0] < a_array[1]

	for i: int in a_array.size() - 1:
		var l_value: int = a_array[i + 1] - a_array[i]

		if (l_positive and l_value < 1) or (!l_positive and l_value > -1):
			return false
		elif  l_value == 0 or absi(l_value) > 3:
			return false

	return true

