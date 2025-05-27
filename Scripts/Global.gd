extends Node

signal player_health_changed
signal inventory_updated

var player_health: float = 100.0

var rng: RandomNumberGenerator
var player_inventory: Dictionary = {
	"ingredients": [],
	"weapons": [],
}

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()	


func add_item(item_name: String, item_type: String):
	if item_type in player_inventory:
		player_inventory[item_type].append(item_name)
		inventory_updated.emit()
	else:
		print("Invalid item type")
	print(player_inventory)