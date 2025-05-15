extends Node2D
@onready var weapon_sprite: AnimatedSprite2D = $WeaponPivot/WeaponSprite
@onready var weapon_pivot: Node2D = $WeaponPivot

var offset_amount: float = 30.0
var offset: float = 30.0

var player: CharacterBody2D

func _ready() -> void:
	player = get_parent()

func _process(_delta: float):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	if mouse_pos.x < player.global_position.x:
		scale.y = -1
		offset = -offset_amount
	else:
		scale.y = +1
		offset = +offset_amount
	position.x = offset
