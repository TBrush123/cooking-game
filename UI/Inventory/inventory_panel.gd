extends Button

@export var options_scene: PackedScene

func _ready() -> void:
	pressed.connect(on_press)

func on_press():
	var options = get_parent().get_parent().get_node("ItemOptions")
	if not options and options_scene:
		var new_options = options_scene.instantiate()
		new_options.position = global_position + Vector2(80, 80)
		get_parent().get_parent().add_child(new_options)
	else:
		options.position = global_position + Vector2(80, 80)
