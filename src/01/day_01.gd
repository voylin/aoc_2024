extends Control

const PATH: String = "res://01/test_data.txt"

func _ready() -> void:
	part_one()
	part_two()


func part_one() -> void:
	var left_list: PackedInt64Array = []
	var right_list: PackedInt64Array = []
	var total: int = 0

	var file: FileAccess = FileAccess.open(PATH, FileAccess.READ)
	var line: PackedStringArray = file.get_line().split("   ")

	while !file.eof_reached():
		left_list.append(int(line[0]))
		right_list.append(int(line[1]))
		line = file.get_line().split("   ")

	left_list.sort()
	right_list.sort()

	for i: int in left_list.size():
		total += abs(left_list[i] - right_list[i])
	
	print("Part one result: ", total)
	

func part_two() -> void:
	var left_list: PackedInt64Array = []
	var right_list: PackedInt64Array = []
	var total: int = 0 # Similarity score 
	var times: int = 0 # Times that a number can be found

	var file: FileAccess = FileAccess.open(PATH, FileAccess.READ)
	var line: PackedStringArray = file.get_line().split("   ")

	while !file.eof_reached():
		left_list.append(int(line[0]))
		right_list.append(int(line[1]))
		line = file.get_line().split("   ")

	for i: int in left_list.size():
		times = 0

		for x: int in left_list.size():
			if left_list[i] == right_list[x]:
				times += 1

		total += left_list[i] * times

	print("Part two result: ", total)
