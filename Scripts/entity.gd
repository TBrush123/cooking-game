extends CharacterBody2D
class_name entity

var health: float = 100.0
var speed: float = 300.0
var attack: float = 7.0

var knockback: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO


func take_damage(amount):
	health -= amount
	print("Current health: %s" % str(health))
	if health <= 0:
		print("%s is kinda dead" % self.name)
