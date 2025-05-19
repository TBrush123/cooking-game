extends CharacterBody2D
class_name TestEnemy

var drop: Array = []

var rarities = {
	0: 1000,
	1: 500,
	2: 250,
	3: 100
}

func _ready() -> void:
	print(get_rarity())
	drop.append(get_rarity())
	print(drop)
	
func get_rarity():
	var weighted_sum = 0

	for i in rarities:
		weighted_sum += rarities[i]
	
	var item = Global.rng.randi_range(0, weighted_sum)

	for n in rarities:
		if item <= rarities[n]:
			return n
		item -= rarities[n]


func _physics_process(_delta: float) -> void:
	move_and_slide()
