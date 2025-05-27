extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 300.0
var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(_delta: float):
	if not player:
		return
	var direction = player.global_position - enemy.global_position

	if direction.length() > 150:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()

	if direction.length() > 500:
		Transitioned.emit(self, "Idle")
