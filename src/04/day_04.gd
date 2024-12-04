extends Node

const PATH: String = "res://04/data.txt"
const XMASS: String = "XMAS"



func part_one() -> int:
	var l_data: PackedStringArray = Data.get_string_array(PATH)
	var l_diagonal_left_data: PackedStringArray = l_data.duplicate()
	var l_diagonal_right_data: PackedStringArray = l_data.duplicate()

	var l_total: int = 0


	for l_column: int in l_data.size():
		var l_line: String = ""

		for l_row: int in l_data.size():
			l_line += l_data[l_row][l_column]

		l_total += _get_xmass_instances(l_data[l_column]) # Horizontal (column is used as row id)
		l_total += _get_xmass_instances(l_line) # Vertical data

		# Diagonal handling (column is used as row id)
		l_diagonal_right_data[l_column] = l_diagonal_right_data[l_column].reverse()
		l_diagonal_left_data[l_column] = " ".repeat(l_column) + l_diagonal_left_data[l_column] + " ".repeat(l_data.size() - l_column)
		l_diagonal_right_data[l_column] = " ".repeat(l_column) + l_diagonal_right_data[l_column] + " ".repeat(l_data.size() - l_column)

	# Diagonal Left + reverse
	for l_column: int in l_diagonal_left_data[0].length():
		var l_line_left: String = ""
		var l_line_right: String = ""

		for l_row: int in l_data.size():
			l_line_left += l_diagonal_left_data[l_row][l_column]
			l_line_right += l_diagonal_right_data[l_row][l_column]

		l_total += _get_xmass_instances(l_line_left) # Diagonal left data
		l_total += _get_xmass_instances(l_line_right) # Diagonal right data
	
	return l_total


func part_two() -> int:
	var l_data: PackedStringArray = Data.get_string_array(PATH)
	var l_total: int = 0

	# Find A positions in the data
	for l_row: int in l_data.size():
		if l_row == 0 or l_row == l_data.size() - 1:
			continue

		for l_column: int in l_data.size():
			if l_column == 0 or l_column == l_data.size() - 1:
				continue

			if l_data[l_row][l_column] == "A":
				var l_check: PackedStringArray = ["M", "S"]
				var l_tl: String = l_data[l_row-1][l_column-1]
				var l_tr: String = l_data[l_row-1][l_column+1]
				var l_bl: String = l_data[l_row+1][l_column-1]
				var l_br: String = l_data[l_row+1][l_column+1]

				if l_tl not in l_check or l_tr not in l_check or l_bl not in l_check or l_br not in l_check:
					continue

				# Check if possible or not
				if l_tl in l_check and l_br in l_check:
					if l_tl == l_br:
						continue
				if l_tr in l_check and l_bl in l_check:
					if l_tr == l_bl:
						continue

				l_total += 1

	return l_total





func _get_xmass_instances(a_line: String) -> int:
	return a_line.count(XMASS) + a_line.reverse().count(XMASS)

