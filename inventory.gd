extends Control

@export var inventory_grid: GridContainer

var inventory: Dictionary


func _ready() -> void:
	hide_invetory()
	update_inventory()
	Global.inventory_updated.connect(update_inventory)

func update_inventory() -> void:
	for cell in inventory_grid.get_children():
		cell.queue_free()

	inventory = Global.player_inventory
	var inventory_size: int = inventory["ingredients"].size() - 1 
	for i in range(16):
		
		var cell = Panel.new()

		if i <= inventory_size:
			var label: Label = Label.new()
			label.text = inventory["ingredients"][i]
			cell.add_child(label)

		cell.custom_minimum_size = Vector2(32, 32)
		inventory_grid.add_child(cell)

func show_inventory() -> void:
	visible = true
	

func hide_invetory() -> void:
	visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
		if visible:
			hide_invetory()
		else:
			show_inventory()
