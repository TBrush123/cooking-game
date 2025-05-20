extends Node2D
class_name HealthComponent

@export var max_health := 100.0
var health: float
var parent

func _ready() -> void:
	parent = get_parent()
	health = max_health

func damage(attack: Attack) -> void:
	health -= attack.attack_damage

	if health <= 0:
		if parent.has_method("drop"):
			var drop_size = parent.drop_items.size()
			for item in range(drop_size):
				parent.drop()
		parent.queue_free()
