extends Control

@export var inventory_grid: GridContainer

var inventory: Dictionary


func _ready() -> void:
	hide_inventory()
	update_inventory()
	Global.inventory_updated.connect(update_inventory)

func update_inventory() -> void:
	for cell in inventory_grid.get_children():
		cell.queue_free()

	inventory = Global.player_inventory
	var ingredients = inventory["ingredients"]
	for i in range(16):
		
		var cell = Panel.new()

		if i < ingredients.size():
			var label: Label = Label.new()
			label.text = ingredients[i]
			cell.add_child(label)

		cell.custom_minimum_size = Vector2(32, 32)
		inventory_grid.add_child(cell)

func show_inventory() -> void:
	visible = true
	

func hide_inventory() -> void:
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Inventory"):
		get_viewport().set_input_as_handled()
		if visible:
			hide_inventory()
		else:
			show_inventory()
