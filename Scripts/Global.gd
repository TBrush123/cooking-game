extends Node

var rng: RandomNumberGenerator

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()


