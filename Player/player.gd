extends CharacterBody2D

@export var item_pickup_hitbox: Area2D

var direction: Vector2 = Vector2.ZERO
var knockback: Vector2 = Vector2.ZERO

var speed: float = 300.0

func take_input() -> Vector2:
	var dir = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		dir.y += -1
	if Input.is_action_pressed("Down"):
		dir.y += 1
	if Input.is_action_pressed("Right"):
		dir.x += 1
	if Input.is_action_pressed("Left"):
		dir.x += -1
	if Input.is_action_just_pressed("Pickup"):
		pickup()

	return dir.normalized()

func _process(_delta: float) -> void:
	direction = take_input()
	velocity = direction * speed + knockback
	move_and_slide()
	knockback = lerp(knockback, Vector2.ZERO, 0.1)

func pickup():
	var areas = item_pickup_hitbox.get_overlapping_areas()
	if areas == null:
		return
	for area in areas:
		if area.has_method("pickup"):
			area.pickup()
			break

func _on_item_pickup_area_area_entered(area:Area2D) -> void:
	if area.has_method("light_up"):
		area.light_up()



func _on_item_pickup_area_area_exited(area:Area2D) -> void:
	if area.has_method("light_down"):
		area.light_down()
