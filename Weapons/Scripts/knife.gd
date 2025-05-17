extends weapon

var speed: float = 1
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func hit() -> void:
	if Input.is_action_just_pressed("Hit"):
		strike()

func strike() -> void:
	attacking = true

	animation_player.play("attack")
	await animation_player.animation_finished

	attacking = false
