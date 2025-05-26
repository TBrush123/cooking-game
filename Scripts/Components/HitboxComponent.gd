extends Area2D
class_name HitboxComponent

@export var attack_damage: float = 10.0
@export var knockback_force: float = 100.0
@export var emitter: String

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(area) -> void:
	if area.has_method("damage") and emitter != area.emitter:
		var attack = Attack.new()

		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position

		area.damage(attack)