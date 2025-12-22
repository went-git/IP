extends Node

func _ready() -> void:
	# Автоматически находим кнопку (если она есть на сцене)
	move_child($TestRoom, 0)
