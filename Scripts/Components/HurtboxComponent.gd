extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent
@export var emitter: String

func damage(attack: Attack) -> void:
	if health_component:
		health_component.damage(attack)