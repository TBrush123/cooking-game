extends State
class_name enemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 100.0

var movement_direction: Vector2
var wander_time: float

var player: CharacterBody2D

func randomize_movement():
	movement_direction = Vector2(Global.rng.randf_range(-1, 1), Global.rng.randf_range(-1, 1)).normalized()
	wander_time = Global.rng.randf_range(1, 3)

func enter():
	randomize_movement()
	player = get_tree().get_first_node_in_group("Player")


func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	
	else:
		randomize_movement()

func Physics_Update(_delta: float):
	if enemy:
		enemy.velocity = movement_direction * move_speed
	if not player:
		return
	var direction = player.global_position - enemy.global_position

	if direction.length() < 400:
		Transitioned.emit(self, "Chase")
