extends Area2D
class_name hurtboxClass

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", Callable(self, "_on_area_entered"))

func _on_area_entered(hitbox: hitboxClass):
	if hitbox == null:
		return 
	if hitbox.emitter != self.get_parent() and self.get_parent().has_method("take_damage"):
		self.get_parent().take_damage(hitbox.damage)
