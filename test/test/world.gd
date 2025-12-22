extends Node
var popup_scene = preload("res://button1.tscn")
func _ready() -> void:
	# Автоматически находим кнопку (если она есть на сцене)
	move_child($TestRoom, 0)


func _on_button_pressed() -> void:
	# Создаем экземпляр из загруженной сцены
	var popup_instance = popup_scene.instantiate()
	
	# Добавляем на текущую сцену
	add_child(popup_instance)
	
	# Ждем инициализации
	await get_tree().process_frame
	
	# Теперь можно позиционировать и показывать
	var button_pos = $Button.global_position
	var button_size = $Button.size
	var pos_x = (button_pos.x + button_size.x / 2) - popup_instance.size.x / 2 + 390
	var pos_y = (button_pos.y + button_size.y / 2) - popup_instance.size.y / 2 +200
	
	popup_instance.position = Vector2(pos_x, pos_y)
"""
func _on_button_pressed() -> void:
	
	var popup_instance = popup_scene.instantiate()
	add_child(popup_instance)
	
	await get_tree().process_frame
	
	popup_instance.size = Vector2(100, 30)
	
	# Получаем глобальный прямоугольник кнопки
	var button_rect = $Button.get_global_rect()
	
	# Используем позицию из глобального прямоугольника
	popup_instance.position = button_rect.position
	
	popup_instance.show()
"""
