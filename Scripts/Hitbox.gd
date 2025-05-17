extends Area2D
class_name hitboxClass

@export var damage: float = 10.0
var emitter: Node = null

func _init() -> void:
	collision_layer = 2
	collision_mask = 0

func _ready() -> void:
	get_node("CollisionShape2D").disabled = true
