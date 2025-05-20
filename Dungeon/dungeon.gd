extends Node2D

func _ready():
	var dungeon = generate_dungeon(21*5, 24*5, 18*5)
	print_dungeon(dungeon, 21*5)

func generate_dungeon(grid_size: int, main_path_length: int, max_side_rooms: int) -> Dictionary:
	var dungeon: Dictionary = {}
	var directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]

	var center = Vector2i(grid_size / 2, grid_size / 2)
	dungeon[center] = "S"
	var path: Array = [center]

	# --- MAIN PATH GENERATION ---
	while path.size() < main_path_length:
		var current = path.back()
		var possible_dirs = []

		for dir in directions:
			var next_room = current + dir * 2
			if is_in_bounds(next_room, grid_size) and not dungeon.has(next_room):
				possible_dirs.append(dir)

		if possible_dirs.is_empty():
			path.pop_back()
			if path.is_empty():
				return generate_dungeon(grid_size, main_path_length, max_side_rooms)
			continue

		var chosen = possible_dirs.pick_random()
		var bridge = current + chosen
		var next_room = current + chosen * 2

		dungeon[bridge] = "C"
		dungeon[next_room] = "M"
		path.append(next_room)

	dungeon[path.back()] = "E"

	# --- SIDE ROOMS GENERATION ---
	var side_rooms_placed = 0
	for room in path:
		if room == path.back():
			continue

		for dir in directions:
			if side_rooms_placed >= max_side_rooms:
				break
			var bridge = room + dir
			var side_room = room + dir * 2
			if is_in_bounds(side_room, grid_size) and not dungeon.has(side_room):
				if randf() < 0.5:
					dungeon[bridge] = "C"
					dungeon[side_room] = "B"
					side_rooms_placed += 1

	return dungeon


func is_in_bounds(pos: Vector2i, grid_size: int) -> bool:
	return pos.x >= 0 and pos.x < grid_size and pos.y >= 0 and pos.y < grid_size


func print_dungeon(dungeon: Dictionary, grid_size: int) -> void:
	for y in range(grid_size):
		var row = ""
		for x in range(grid_size):
			var pos = Vector2i(x, y)
			if dungeon.has(pos):
				row += str(dungeon[pos]) + " "
			else:
				row += ". "
		print(row)
