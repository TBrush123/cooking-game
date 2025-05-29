extends Node

signal player_health_changed
signal inventory_updated
signal inventory_cell_pressed

var player_health: float = 100.0

var rng: RandomNumberGenerator
var player_inventory: Dictionary = {
	"ingredients": [],
	"weapons": [],
}

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()	


func add_item(item_name: String, item_type: String) -> bool:
	if item_name.is_empty():
		print("???")
		return false
	if item_type in player_inventory:
		player_inventory[item_type].append(item_name)
		inventory_updated.emit()
		return true
	else:
		print("Invalid item type")
		return false
	print(player_inventory)