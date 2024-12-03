extends Control

const PATH: String = "res://02/data.txt"


func part_one() -> int:
	var l_data: Array[PackedInt64Array] = Data.get_packed_int_array(PATH, " ")
	var l_total: int = 0

	for l_index: int in l_data.size():
		var l_positive: bool = true
		var l_skip: bool = false

		if l_data[l_index][0] > l_data[l_index][1]:
			l_positive = false

		for i: int in l_data[l_index].size() - 1:
			var l_value: int = l_data[l_index][i + 1] - l_data[l_index][i]

			if (l_positive and l_value < 0) or (!l_positive and l_value > 0):
				l_skip = true
				break
			if absi(l_value) > 3 or l_value == 0:
				l_skip = true
				break

		if !l_skip:
			l_total += 1
	
	return l_total


func part_two() -> int:
	var l_total: int = 0

	for l_array: PackedInt64Array in Data.get_packed_int_array(PATH, " "):
		if _check_normal(l_array):
			l_total += 1
			continue

		for i:int in l_array.size():
			var l_temp: PackedInt64Array = l_array.duplicate()
			l_temp.remove_at(i)

			if _check_normal(l_temp):
				l_total += 1
				break

	return l_total


func _check_normal(a_array: PackedInt64Array) -> bool:
	var l_positive: bool = a_array[0] < a_array[1]

	for i: int in a_array.size() - 1:
		var l_value: int = a_array[i + 1] - a_array[i]

		if (l_positive and l_value < 1) or (!l_positive and l_value > -1):
			return false
		elif  l_value == 0 or absi(l_value) > 3:
			return false

	return true

