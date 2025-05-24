extends Node2D
class_name HealthComponent

@export var max_health := 100.0
@export var sparkle_scene: PackedScene

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
		var sparkle = sparkle_scene.instantiate()
		sparkle.position = global_position

		parent.get_parent().add_child(sparkle)
		sparkle.color = Color(1.0, 0.0, 0.0, 1.0)
		sparkle.restart()

		parent.queue_free()
