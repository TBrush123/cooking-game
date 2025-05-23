extends Node2D

const BORDER_PATH := "res://Dungeon/Rooms/RoomBorder/"
const CONTENT_PATH := "res://Dungeon/Rooms/RoomContent/"

var border_cache := {}
var content_chache := {}

@export var room_scene: PackedScene

@export var bridge_horiz_scene: PackedScene
@export var bridge_vert_scene: PackedScene

func _ready():
	var dungeon = generate_dungeon(10, 10, 10)
	create_dungeon(dungeon, 10)
	print_dungeon(dungeon, 10)

# --- Border Handling ---
func get_border_scene(direction: String, is_open: bool) -> PackedScene:
	var state := "open" if is_open else "closed"
	var name := "border_%s_%s" % [direction.to_lower(), state]

	if not border_cache.has(name):
		var scene = load(BORDER_PATH + name + ".tscn")
		if scene:
			border_cache[name] = scene
		else:
			push_error("Missing border scene: " + name)
			return null
	
	return border_cache[name]

func get_content_scene(content: String) -> PackedScene:

	if not content_chache.has(name):
		var scene = load(CONTENT_PATH + content + ".tscn")
		if scene:
			border_cache[name] = scene
		else:
			push_error("Missing border scene: " + name)
			return null
	
	return border_cache[name]


func get_wall_config(pos: Vector2i, dungeon: Dictionary) -> Dictionary:
	return {
		"up": has_room(pos + Vector2i(0, -1), dungeon),
		"down": has_room(pos + Vector2i(0, 1), dungeon),
		"left": has_room(pos + Vector2i(-1, 0), dungeon),
		"right": has_room(pos + Vector2i(1, 0), dungeon),
	}

func has_room(pos: Vector2i, dungeon: Dictionary) -> bool:
	return dungeon.has(pos) and dungeon[pos] != ""


func assemble_room(pos: Vector2i, dungeon: Dictionary, parent: Node2D, content: String):
	var config = get_wall_config(pos, dungeon)

	for direction in config.keys():
		var border_scene = get_border_scene(direction, config[direction])
		if not border_scene:
			return
		var border_instance = border_scene.instantiate()
		parent.get_node("Borders").add_child(border_instance)

		var content_scene = get_content_scene(content)
		if not content_scene:
			return
		var content_instance = content_scene.instantiate()
		parent.get_node("Content").add_child(content_instance)

# --- Dungeon Generation ---
func generate_dungeon(grid_size: int, main_path_length: int, max_side_rooms: int) -> Dictionary:
	var dungeon: Dictionary = {}
	var directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]

	var center = Vector2i(grid_size / 2, grid_size / 2)
	dungeon[center] = "S"
	var path: Array = [center]

	# MAIN PATH
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

		var chosen = possible_dirs[Global.rng.randi_range(0, possible_dirs.size()-1)]
		var bridge = current + chosen
		var next_room = current + chosen * 2

		dungeon[bridge] = "C"
		dungeon[next_room] = "M"
		path.append(next_room)

	dungeon[path.back()] = "E"

	# SIDE ROOMS
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
				if Global.rng.randf() < 0.5:
					dungeon[bridge] = "C"
					dungeon[side_room] = "B"
					side_rooms_placed += 1
					path.insert(path.size() - 2, side_room)

	return dungeon

func is_in_bounds(pos: Vector2i, grid_size: int) -> bool:
	return pos.x >= 0 and pos.x < grid_size and pos.y >= 0 and pos.y < grid_size

func print_dungeon(dungeon: Dictionary, grid_size: int) -> void:
	for y in range(grid_size):
		var row = ""
		for x in range(grid_size):
			var pos = Vector2i(x, y)
			row += (dungeon.get(pos, ".") + " ")
		print(row)

func create_dungeon(dungeon, grid_size):
	for y in range(grid_size):
		for x in range(grid_size):
			var pos = Vector2i(x, y)
			if dungeon.has(pos):
				var kind = dungeon[pos]
				var room = null

				match kind:
					"M", "B", "S", "E":
						room = room_scene.instantiate()
						room.position = pos * 8 * 16
						add_child(room)
						assemble_room(pos, dungeon, room, "Basic")
					"C":
						if dungeon.has(pos + Vector2i(0, 1)):
							room = bridge_vert_scene.instantiate()
						else:
							room = bridge_horiz_scene.instantiate()
						room.position = pos * 8 * 16
						add_child(room)
