extends Node2D
class_name HealthComponent

@export var max_health := 100.0
@export var sparkle_scene: PackedScene
@export var sparkle_color := Color(1.0, 0.0, 0.0, 1.0)

var health: float
var parent

func _ready() -> void:
	parent = get_parent()
	health = max_health
	
	if parent.is_in_group("Player"):
		Global.player_health = health


func damage(attack: Attack) -> void:
	health -= attack.attack_damage

	if parent.is_in_group("Player"):
		Global.player_health = health
		Global.player_health_changed.emit()

	if health <= 0:
		if parent.has_method("drop"):
			var drop_size = parent.drop_items.size()
			for item in range(drop_size):
				parent.drop()

		if not sparkle_scene:
			return

		var sparkle = sparkle_scene.instantiate()

		if not sparkle:
			return

		sparkle.position = global_position
		var grandparent = parent.get_parent() if parent else null

		if not grandparent:
			return

		parent.get_parent().add_child(sparkle)
		sparkle.color = sparkle_color
		if sparkle.has_method("restart"):
				sparkle.restart()
		parent.queue_free()
