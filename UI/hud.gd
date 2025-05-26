extends Control
@export var health_bar: ProgressBar

func _ready() -> void:
	Global.player_health_changed.connect(change_health)
	health_bar.value = Global.player_health

func change_health():
	health_bar.value = Global.player_health
