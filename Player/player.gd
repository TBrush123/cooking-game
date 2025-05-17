extends entity

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

	return dir.normalized()

func _process(_delta: float) -> void:
	direction = take_input()
	velocity = direction * speed + knockback
	move_and_slide()
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
