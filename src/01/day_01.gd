extends Control



func _ready() -> void:
	print("Day 01 - Part one result: ", part_one())
	print("Day 01 - Part two result: ", part_two())


func part_one() -> int:
	var data: Array[PackedInt64Array] = _read_data()
	var total: int = 0

	data[0].sort()
	data[1].sort()

	for i: int in data[0].size():
		total += abs(data[0][i] - data[1][i])
	return total
	

func part_two() -> int:
	var data: Array[PackedInt64Array] = _read_data()
	var total: int = 0 # Similarity score 

	for number: int in data[0]:
		total += number * data[1].count(number)
	return total


func _read_data() -> Array[PackedInt64Array]:
	var data: Array[PackedInt64Array] = [[],[]]

	var file: FileAccess = FileAccess.open("res://01/test_data.txt", FileAccess.READ)
	var line: PackedStringArray = file.get_line().split("   ")

	while !file.eof_reached():
		data[0].append(int(line[0]))
		data[1].append(int(line[1]))
		line = file.get_line().split("   ")

	return data

