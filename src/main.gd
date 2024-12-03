extends Control

@export_range(0, 25) var day: int
@export_range(0,2) var part: int


func _ready() -> void:
	if day == 0: # Select current day
		day = Time.get_date_dict_from_system().day
	
	var l_print_string: String = "Part %s result: %s"
	
	print_rich("[b]Day %02d[/b]" % day)

	if part == 1 or part == 0:
		var l_value = find_child("%02d" % day).call("part_one")
		print(l_print_string % ["one", l_value])
	if part == 2 or part == 0:
		var l_value = find_child("%02d" % day).call("part_two")
		print(l_print_string % ["two", l_value])

	
func _get_part_one() -> void:
	pass
	


func _get_part_two() -> void:
	pass

