extends Area2D
@export var sprite: Sprite2D
@export var item_name: String

func set_texture(textPath: String):
	print(textPath)
	sprite.texture = load(textPath)

func set_new_name(new_name: String):
	item_name = new_name
