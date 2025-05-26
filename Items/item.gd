extends Area2D
@export var sprite: Sprite2D
@export var item_name: String
@export var label: Label
@export var pickup_sparkle_scene: PackedScene

var allow_pickup := false

func set_texture(textPath: String):
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
	if pickup_sparkle_scene:
		var pickup_sparkle = pickup_sparkle_scene.instantiate()
		pickup_sparkle.position = global_position
		get_parent().add_child(pickup_sparkle)
		pickup_sparkle.restart()
		
	Global.add_ingredient(item_name)
	queue_free()
