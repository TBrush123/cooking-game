extends Area2D

var knockback_strength: float = 1000.0
var attack: float = 12

func _on_body_entered(body:Node2D) -> void:
    if body.name == "Player":
        var direction = global_position.direction_to(body.global_position)
        body.knockback = direction * knockback_strength
        body.take_damage(attack)
        print(body.health)
