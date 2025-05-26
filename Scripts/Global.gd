extends Node

signal player_health_changed

var player_health: float = 100.0

var rng: RandomNumberGenerator
var player_inventory: Dictionary = {
	"Ingredients": [],
	"Weapons": [],
}

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()	


func add_ingredient(item_name: String):
	player_inventory["Ingredients"].append(item_name)
	print(player_inventory["Ingredients"])
