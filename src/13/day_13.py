from typing import List

PATH = "data.txt"


class Machine:
    def __init__(self):
        self.a_button = (0, 0)
        self.b_button = (0, 0)
        self.prize = (0, 0)

    def get_coins(self, a_times: int, b_times: int) -> int:
        return (a_times * 3) + b_times


def part_one() -> int:
    global machines
    machines = get_machines(0)
    total = 0
    completed = 0

    print("Part one: " + str(completed) + "/320", end="\r")
    for l_machine in machines:
        total += calculate_machine(l_machine)
        completed += 1
        print("Part one: " + str(completed) + "/320", end="\r")

    print("Part one: 320/320")
    print(total)


def part_two() -> int:
    global machines, total
    machines = get_machines(10000000000000)
    total = 0
    completed = 0

    print("Part two: " + str(completed) + "/320", end="\r")
    for l_machine in machines:
        total += calculate_machine(l_machine)
        completed += 1
        print("Part two: " + str(completed) + "/320", end="\r")

    print("Part two: 320/320")
    print(total)


def get_machines(a_prize_pos_addition: int) -> List['Machine']:
    l_data = get_string_array(PATH)
    l_arr = []

    for l_line in l_data:
        if "Button A" in l_line:
            machine = Machine()
            machine.a_button = (
                int(l_line.split(' ')[-2].replace('X+', '').replace(',', '')),
                int(l_line.split(' ')[-1].replace('Y+', ''))
            )
            l_arr.append(machine)
        elif "Button B" in l_line:
            l_arr[-1].b_button = (
                int(l_line.split(' ')[-2].replace('X+', '').replace(',', '')),
                int(l_line.split(' ')[-1].replace('Y+', ''))
            )
        elif "Prize:" in l_line:
            l_arr[-1].prize = (
                int(l_line.split(' ')[-2].replace('X=', '').replace(',', '')) + a_prize_pos_addition,
                int(l_line.split(' ')[-1].replace('Y=', '')) + a_prize_pos_addition
            )

    return l_arr


def calculate_machine(a_machine: Machine) -> int:
    l_max_a = max((a_machine.prize[0] / a_machine.a_button[0]) + 1, (a_machine.prize[1] / a_machine.a_button[1]) + 1)
    l_max_b = max((a_machine.prize[0] / a_machine.b_button[0]) + 1, (a_machine.prize[1] / a_machine.b_button[1]) + 1)

    l_x = 0
    l_y = 0

    l_coins = []

    for l_test in [
            (a_machine.a_button[0], a_machine.b_button[0], a_machine.prize[0]),
            (a_machine.a_button[1], a_machine.b_button[1], a_machine.prize[1])]:
        while l_test[1] != 0:
            l_test = (l_test[1], l_test[0] % l_test[1], l_test[2])
        if l_test[2] % l_test[0] != 0:
            return 0

    for x in range(0, int(max(l_max_a, l_max_b))):
        l_x = a_machine.prize[0] - x * a_machine.a_button[0]
        if l_x < 0:
            continue

        l_y = a_machine.prize[1] - x * a_machine.a_button[1]
        if l_y < 0:
            continue

        if l_x % a_machine.b_button[0] == 0 and l_y % a_machine.b_button[1] == 0:
            l_new_b = int(l_x / a_machine.b_button[0])
            if l_new_b >= 0:
                l_coins.append(a_machine.get_coins(x, l_new_b))

    l_coins.sort()
    if len(l_coins) != 0:
        return l_coins[0]
    return 0


def get_string_array(path: str) -> List[str]:
    data = []

    try:
        with open(PATH, 'r') as file:
            for line in file:
                data.append(line.strip())  # strip() removes the newline character
    except FileNotFoundError:
        print(f"File not found: {PATH}")
    except IOError as e:
        print(f"Error reading file: {e}")

    return data


part_one()
part_two()
