extends Node

var rng: RandomNumberGenerator
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.seed = hash("Dauren")

