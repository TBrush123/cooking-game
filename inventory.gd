extends Panel

@export var inventory_grid: GridContainer
@export var inventory_panel: PackedScene

const ITEM_ASSETS_PATH: String = "res://Items/Assets/"

var item_asset_buffer: Dictionary = {}

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

	if not inventory_panel:
		print("No inventory scene!")
		return

	for i in range(16):
		
		var cell = inventory_panel.instantiate()

		if i < ingredients.size():
			var texture = load_texture(ingredients[i])
			if texture:
				cell.get_node("TextureRect").texture = texture

		inventory_grid.add_child(cell)

func show_inventory() -> void:
	visible = true
	get_tree().paused = true
	

func hide_inventory() -> void:
	visible = false
	get_tree().paused = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Inventory"):
		get_viewport().set_input_as_handled()
		if visible:
			hide_inventory()
		else:
			show_inventory()

func load_texture(texture_name) -> CompressedTexture2D:
	if texture_name in item_asset_buffer:
		return item_asset_buffer[texture_name]
	
	var new_texture_path = ITEM_ASSETS_PATH + "Food_" + texture_name + ".png"

	if not ResourceLoader.exists(new_texture_path):
		print("Warning: Texture not found at path: ", new_texture_path)
		return null
	
	var new_texture = load(new_texture_path)
	if not new_texture:
		print("Failed to load texture: ", new_texture_path)
		return null
	
	item_asset_buffer[texture_name] = new_texture

	return new_texture
