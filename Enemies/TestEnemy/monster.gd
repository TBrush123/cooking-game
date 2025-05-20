extends CharacterBody2D
class_name TestEnemy

@export var item_scene: PackedScene

var drop_items: Array


var rarities = {
	0: 1000,
	1: 500,
	2: 250,
	3: 100
}

func _ready() -> void:
	for i in range(3):
		drop_items.append(get_rarity())
		
	print(drop_items)
	
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

func drop() -> void:
	var item = item_scene.instantiate()
	get_parent().add_child(item)
	item.position = global_position + Vector2(Global.rng.randf_range(-1, 1), Global.rng.randf_range(-1, 1)) * 200
	var dropped_item = drop_items.pop_front()
	
	var item_path := "res://Items/Assets/Food_%s.png" % str(dropped_item)
	
	item.set_texture(item_path)
	item.set_new_name(str(dropped_item))
