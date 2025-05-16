extends weapon

var speed: float = 1

func hit() -> void:
	if Input.is_action_just_pressed("Hit"):
		strike()

func strike() -> void:
	monitoring = true
	await get_tree().create_timer(speed).timeout
	monitoring = false
