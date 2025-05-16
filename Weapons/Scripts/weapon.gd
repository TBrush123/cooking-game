extends Area2D
class_name weapon
@onready var weapon_sprite: AnimatedSprite2D = $WeaponPivot/WeaponSprite
@onready var weapon_pivot: Node2D = $WeaponPivot

var offset_amount: float = 30.0
var offset: float = 30.0
var attacking: bool = false
var player: CharacterBody2D
var damage: float = 10.0

func _ready() -> void:
	player = get_parent()
	connect("body_entered", check_hit)

func _process(_delta: float) -> void:
	hit()
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	if mouse_pos.x < player.global_position.x:
		scale.y = -1
		offset = -offset_amount
	else:
		scale.y = +1
		offset = +offset_amount
	position.x = offset
	

func hit() -> void:
	pass

func check_hit(body):
	if body.has_method("take_damage") and body.is_in_group("enemies"):
		body.take_damage(damage)
