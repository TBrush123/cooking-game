extends Node2D
class_name weapon

@onready var weapon_sprite: Sprite2D = $WeaponPivot/WeaponSprite
@onready var hitbox_class: Area2D = $WeaponPivot/WeaponSprite/hitboxClass

var offset_amount: float = 30.0
var offset: float = 30.0
var attacking: bool = false
var player: CharacterBody2D
var parent: CharacterBody2D
var damage: float = 10.0

func _ready() -> void:
	player = get_parent()
	hitbox_class.emitter = player

func _process(_delta: float) -> void:
	
	if attacking:
		return
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
