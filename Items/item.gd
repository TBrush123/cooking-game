extends Area2D
@export var sprite: Sprite2D
@export var item_name: String
@export var label: Label

var allow_pickup := false

func set_texture(textPath: String):
	print(textPath)
	sprite.texture = load(textPath)
	

func set_new_name(new_name: String):
	item_name = new_name
	
func light_up() -> void:
	sprite.material.set_shader_parameter("onoff", true)
	label.text = "Press E to pickup!"

func light_down() -> void:
	sprite.material.set_shader_parameter("onoff", false)
	label.text = ""

func pickup():
	Global.add_ingredient(item_name)
	queue_free()