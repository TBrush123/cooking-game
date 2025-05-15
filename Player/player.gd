extends CharacterBody2D

var speed: float = 300.0
var knockback: Vector2 = Vector2.ZERO

func take_input() -> Vector2:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		direction.y += -1
	if Input.is_action_pressed("Down"):
		direction.y += 1
	if Input.is_action_pressed("Right"):
		direction.x += 1
	if Input.is_action_pressed("Left"):
		direction.x += -1

	return direction.normalized()

func _process(_delta: float) -> void:
	var direction = take_input()

	velocity = direction * speed + knockback
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	
	move_and_slide()
